import 'dart:convert';
import 'dart:math';

import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/api.dart';
import '../../data/models/history_booking_model.dart';

class ControllerDashboard extends GetxController {
  RxInt currentIndex = 0.obs;
  var isLoading = false.obs;
  var isLoadingChart = false.obs;
  var message = ''.obs;
  var idUsers = ''.obs;
  var ticketUser = <HistoryBookingModel>[].obs;
  var barGroups = <BarChartGroupData>[].obs;
  var jamLayanan = <String>[].obs;
  var namaLayanan = <String>[].obs;
  var layanan = <Map<String, dynamic>>[].obs;
  var maxY = 0.0.obs;
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());

  void getIndex(int current) {
    currentIndex.value = current;
  }

  Future<List<HistoryBookingModel>> fetchGetTicketUser(String idUser) async {
    print("kesini ga bang");
    isLoading(true);
    try {
      final response = await http.post(Uri.parse('${apiService}getTicketUser'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'id_users': idUser}));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        var data = jsonDecode(response.body)['data'];
        List<HistoryBookingModel> getTicketUser =
            List<HistoryBookingModel>.from(
                data.map((i) => HistoryBookingModel.fromJson(i)));
        ticketUser.assignAll(getTicketUser);
        return ticketUser;
      } else if (code == 404) {
        message.value = "tidak ada ticket booking";
        return [];
      } else {
        message.value = "Failed to load ticket booking";
        return [];
      }
    } catch (e) {
      throw Exception("error : $e");
    } finally {
      isLoading(false);
    }
  }

  // void assignTicketUser(String idUser) async {
  //   try {
  //     isLoading(true);
  //     var getTicketUser = await fetchGetTicketUser(idUser);
  //     if (getTicketUser.isNotEmpty) {
  //       ticketUser.assignAll(getTicketUser);
  //       print("DONEE ${ticketUser[1].nomorBooking}");
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void assignTicketUser(String idUser) async {
    await fetchGetTicketUser(idUser);
  }

  Future<void> fetchChartData() async {
    try {
      isLoadingChart(true);
      final response = await http.get(Uri.parse('${apiService}getbookuser'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        jamLayanan.value = List<String>.from(jsonData['data']['hours']);
        // namaLayanan.value = List<String>.from(jsonData['data']['layanan']);
        layanan.value =
            List<Map<String, dynamic>>.from(jsonData['data']['layanan']);

        var bookingsData = jsonData['data']['data'];
        List<BarChartGroupData> loadedBarGroups = [];
        double highestBookingCount = 0.0;

        for (var data in bookingsData) {
          List<BarChartRodData> rods = [];
          for (var booking in data['bookings']) {
            double bookingCount =
                double.parse(booking['booking_count'].toString());
            if (bookingCount > highestBookingCount) {
              highestBookingCount = bookingCount;
            }
            rods.add(
              BarChartRodData(
                toY: double.parse(booking['booking_count'].toString()),
                color: getColorForService(
                    booking['service_id']), // Warna berdasarkan ID layanan
                borderRadius: BorderRadius.circular(0),
              ),
            );
          }
          loadedBarGroups.add(BarChartGroupData(
            x: data['x'],
            barRods: rods,
          ));
        }

        barGroups.value = loadedBarGroups;
        maxY.value = highestBookingCount;
      } else {
        Get.snackbar('Error', 'Failed to fetch chart data');
      }
    } catch (e) {
      print("EROR GEDEN : ${e.toString()}");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingChart(false);
    }
  }

  Color getColorForService(int serviceId) {
    // Cocokkan serviceId dengan id_layanan dari daftar layanan
    layanan.firstWhere((element) => element['id_layanan'] == serviceId,
        orElse: () => {});

    // Berikan warna sesuai dengan layanan
    switch (serviceId) {
      case 1:
        return const Color.fromRGBO(197, 217, 255, 1);
      case 2:
        return yellowActive;
      case 3:
        return bluePrimary;
      default:
        return generateRandomColor(serviceId); // Warna default jika tidak cocok
    }
  }

  Color generateRandomColor(int serviceId) {
    Random random = Random(serviceId);
    return Color.fromRGBO(
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
      1, // Opacity
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchChartData();
    if (controllerLogin.user.value?.idUsers.toString() != null) {
      assignTicketUser(controllerLogin.user.value?.idUsers.toString() ?? '');
    }

    controllerLogin.user.listen((userModel) {
      if (userModel != null) {
        print("after login ${userModel.idUsers.toString()}");
        assignTicketUser(userModel.idUsers.toString());
      } else {
        print("User is null or logged out");
        ticketUser.clear(); // Clear tickets on logout
      }
    });
  }
}
