import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/times_slot.dart';

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
  var availableSlots = 0.obs;
  final Rx<LoketInfo?> loketInfo = Rx<LoketInfo?>(null);

  void changeFocusedDay(DateTime focus) {
    focusedDay.value = focus;
  }

  bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  void changeSelectedDay(DateTime select) {
    if (select.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      selectedDay.value = select;
      selectedTime.value = '';
      availableLoket.clear();
      availableSlots.value = 0;
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
        Uri.parse('${apiService}booking'),
        body: jsonEncode({
          'tanggal': selectedDay.value!.toIso8601String().split('T')[0],
          'id_layanan': serviceId.value,
          'id': 1
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // Parse available times with remaining slots
        List<TimeSlot> availableSlots =
            (jsonData['data']['time_slots']['available'] as List)
                .map((slot) => TimeSlot(
                      time: slot['time'],
                      remainingSlots: slot['remaining_slots'],
                      available: true,
                    ))
                .toList();

        // Parse non-available times
        List<TimeSlot> nonAvailableSlots =
            (jsonData['data']['time_slots']['non_available'] as List)
                .map((time) => TimeSlot(
                      time: time,
                      remainingSlots: 0,
                      available: false,
                    ))
                .toList();

        // Combine and sort all time slots
        List<TimeSlot> allSlots = [...availableSlots, ...nonAvailableSlots];
        allSlots.sort((a, b) => a.time.compareTo(b.time));

        // Update your times list with the new format
        times.clear();
        for (var slot in allSlots) {
          String formattedTime =
              slot.time.substring(0, 5); // Converts "08:00:00" to "08:00"
          times.add({
            'time': formattedTime,
            'available': slot.available,
            'remaining_slots': slot.remainingSlots,
          });
        }
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } on SocketException {
      snackBarError("Periksa Koneksi Internet",
          "Gagal mendapatkan data harap periksa koneksi internet");
      times.clear();
    } catch (e) {
      print('Error: $e');
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
      } on SocketException {
        snackBarError("Perika Koneksi Internet",
            "Gagal mendapatkan data harap periksa koneksi internet");

        availableLoket.clear();
      } catch (e) {
        print('mengalami error : $e');
      } finally {
        isLoadingLoket(false);
      }
    }
  }

  Future<void> insertBooking(
      {String? alamat,
      String? idLayanan,
      String? jamBooking,
      String? tanggal,
      String? idUser,
      String? layanan}) async {
    isLoading(true);
    bool check = checkDataNullBooking(jamBooking!, tanggal!);
    if (!check) {
      try {
        final jakarta = tz.getLocation('Asia/Jakarta');
        final jakarataDateTime = tz.TZDateTime.now(jakarta);
        String currentDateTime = jakarataDateTime.toString();
        final response =
            await http.post(Uri.parse('${apiService}insertbooking'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  'id_layanan': idLayanan,
                  'jam_booking': jamBooking,
                  'tanggal': tanggal,
                  'id_users': idUser,
                  'created_at': currentDateTime
                }));

        final responseBody = json.decode(response.body);
        int code = responseBody['meta']['code'];
        print(responseBody);

        if (code == 200) {
          if (responseBody['meta']['status'] == 'success') {
            Get.toNamed(Routes.bookingDoneScreen,
                arguments: {'layanan': layanan});
          }
        } else if (code == 500) {
          Get.back();
          snackBarError("Gagal buat booking pesanan",
              "Terjadi kesalahan saat melakukan booking pesanan");
        } else if (code == 400) {
          Get.back();
          snackBarError("Gagal buat booking pesanan",
              "Tanggal tersebut dan loket tersebut sudah terdapat data booking mohon cari yang lain");
        } else if (code == 402) {
          Get.back();
          snackBarError("Gagal buat booking pesanan",
              "Harap pesan pada jam lain karena sudah booking pada jam tersebut");
        }
      } on SocketException {
        Get.back();
        snackBarError("Perika Koneksi Internet",
            "Gagal mengirim data harap periksa koneksi internet");
      } catch (e) {
        print(e);
      } finally {
        isLoading(false);
      }
    } else {
      isLoading(false);
    }
  }

  bool checkDataNullBooking(String jamBooking, String tanggal) {
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
    return false;
  }
}
