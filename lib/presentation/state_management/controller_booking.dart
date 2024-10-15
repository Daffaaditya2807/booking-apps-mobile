import 'dart:convert';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerBooking extends GetxController {
  var isLoading = false.obs;
  var isFirstLoadValue = true.obs;
  var isLoadingLoket = false.obs;
  var focusedDay = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();
  var availableTimes = <String>[].obs;
  var nonAvailableTimes = <String>[].obs;
  var times = <Map<String, dynamic>>[].obs;
  var selectedTime = ''.obs;
  var selectedLocket = ''.obs;
  var serviceId = 0.obs;
  //hosting
  var availableLoket = <String>[].obs;
  //local
  // var availableLoket = <int>[].obs;
  var jamBooking = ''.obs;
  var tags = ''.obs;

  void changeFocusedDay(DateTime focus) {
    focusedDay.value = focus;
  }

  void changeSelectedDay(DateTime select) {
    if (select.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      selectedDay.value = select;
      selectedTime.value = '';
      availableLoket.clear();
      isLoadingLoket(false);
      isFirstLoadValue(true);
      fetchAvailableTimes();
    }
  }

  bool isSelectable(DateTime day) {
    return day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
  }

  Future<void> fetchAvailableTimes() async {
    if (isFirstLoadValue.value) {
      isLoading(true);
    }
    try {
      if (selectedDay.value == null) return;
      var response = await http.post(
        Uri.parse('${apiService}booking'), // Ganti dengan URL API Anda
        body: jsonEncode({
          'tanggal': selectedDay.value!.toIso8601String().split('T')[0],
          'id_layanan': serviceId.value,
          'id': 1
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<String> available =
            List<String>.from(jsonData['data']['time_slots']['available']);
        List<String> nonAvailable =
            List<String>.from(jsonData['data']['time_slots']['non_available']);
        List<String> allTimes = (available + nonAvailable).toSet().toList()
          ..sort(); // Remove duplicates and sort

        times.clear();
        for (String time in allTimes) {
          String formattedTime =
              time.substring(0, 5); // Converts "08:00:00" to "08:00"
          times.add(
              {'time': formattedTime, 'available': available.contains(time)});
        }
      } else {
        // Handle error
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
      isFirstLoadValue(false);
    }
  }

  Future<void> fetchAvailableLoket() async {
    if (!isFirstLoadValue.value) {
      isLoadingLoket(true);
      try {
        var response = await http.post(
          Uri.parse('${apiService}loket'), // Update the API URL here
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'tanggal': selectedDay.value!
                .toIso8601String()
                .split('T')[0], // Date in YYYY-MM-DD format
            'id_layanan': serviceId.value, // Service ID
            'jam_booking': jamBooking.value // Booking time
          }),
        );

        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          //Hosting
          List<String> lokets =
              List<String>.from(jsonData['data']['available_loket']);
          //local
          // List<int> lokets =
          //     List<int>.from(jsonData['data']['available_loket']);
          availableLoket.assignAll(lokets);
        } else {
          // Handle error
          print('Error loading data: ${response.statusCode}');
          availableLoket.clear();
        }
      } catch (e) {
        print('mengalami error : $e');
      } finally {
        isLoadingLoket(false);
      }
    }
  }

  Future<void> insertBooking(
      {String? idPelayanan,
      String? alamat,
      String? idLayanan,
      String? jamBooking,
      String? tanggal,
      String? idUser}) async {
    isLoading(true);
    bool check = checkDataNullBooking(jamBooking!, tanggal!, idPelayanan!);
    if (!check) {
      try {
        final response =
            await http.post(Uri.parse('${apiService}insertbooking'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  'no_pelayanan': idPelayanan,
                  'id_layanan': idLayanan,
                  'jam_booking': jamBooking,
                  'tanggal': tanggal,
                  'id_users': idUser
                }));

        final responseBody = json.decode(response.body);
        int code = responseBody['meta']['code'];
        print(responseBody);

        if (code == 200) {
          if (responseBody['meta']['status'] == 'success') {
            Get.toNamed(Routes.bookingDoneScreen);
          }
        } else if (code == 500) {
          snackBarError("Gagal buat booking pesanan",
              "Terjadi kesalahan saat melakukan booking pesanan");
        } else if (code == 400) {
          snackBarError("Gagal buat booking pesanan",
              "Tanggal tersebut dan loket tersebut sudah terdapat data booking mohon cari yang lain");
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading(false);
      }
    } else {
      isLoading(false);
    }
  }

  bool checkDataNullBooking(
      String jamBooking, String tanggal, String idPelayanan) {
    if (tanggal.isEmpty) {
      snackBarError("tanggal booking kosong",
          "Harap pilih tanggal booking terlebih dahulu");
      return true;
    }
    if (jamBooking.isEmpty) {
      snackBarError(
          "Jam Booking Kosong", "Harap pilih jam booking terlebih dahulu");
      return true;
    }
    if (idPelayanan.isEmpty) {
      snackBarError("Nomor Loket kosong",
          "Harap pilih Nomor Loket booking terlebih dahulu");
      return true;
    }

    return false;
  }
}
