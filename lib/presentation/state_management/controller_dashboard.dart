import 'dart:convert';
import 'dart:math';

import 'package:apllication_book_now/data/data_sources/notification_helper.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  var historyPesan = <HistoryBookingModel>[].obs;
  List urlImagee = [].obs;

  final ControllerLogin controllerLogin = Get.put(ControllerLogin());
  NotificationHelper notificationHelper = NotificationHelper();
  void getIndex(int current) {
    currentIndex.value = current;
  }

  Future<List<HistoryBookingModel>> fetchGetTicketUser(String idUser) async {
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

  Future<List<HistoryBookingModel>> fetchHistory(
      String idUser, String status) async {
    try {
      final response = await http.post(
          Uri.parse('${apiService}gethistorybooking'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'id_users': idUser, 'status': status}));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        var data = jsonDecode(response.body)['data'];
        List<HistoryBookingModel> historyProses =
            List<HistoryBookingModel>.from(
                data.map((i) => HistoryBookingModel.fromJson(i)));
        historyProses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return historyProses;
      } else if (code == 404) {
        message.value = "tidak ada history booking";
        return [];
      } else {
        message.value = "Failed to load history booking";
        return [];
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }

  void assignAllHistoryPesan(String idUser) async {
    try {
      // isLoading(true);
      var historyPesanList = await fetchHistory(idUser, 'dipesan');
      if (historyPesanList.isNotEmpty) {
        historyPesan.assignAll(historyPesanList);
      }
    } finally {
      // isLoading(false);
    }
  }

  Future<List> urlImageBanners() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('${apiService}getbanners'),
        headers: {'Content-Type': 'application/json'},
      );
      // Cek status kode HTTP
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        int code = responseBody['meta']['code'];

        // Cek kode dari response JSON
        if (code == 200) {
          List banners = responseBody['data']['data'];
          urlImagee.assignAll(banners);
          return urlImagee;
        } else if (code == 500) {
          snackBarError(
              "Gagal mendapatkan list banner", "ada sesuatu yang error");
          return [];
        } else {
          return [];
        }
      } else {
        snackBarError("Gagal mendapatkan list banner",
            "HTTP Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      snackBarError("Error", "Terjadi kesalahan: $e");
      return [];
    } finally {
      isLoading(false);
    }
  }

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
          List<int> indicators = [];
          for (var i = 0; i < data['bookings'].length; i++) {
            var booking = data['bookings'][i];
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
            if (bookingCount > 0) {
              indicators.add(i);
            }
          }
          loadedBarGroups.add(BarChartGroupData(
              x: data['x'],
              barRods: rods,
              showingTooltipIndicators: indicators));
        }

        barGroups.value = loadedBarGroups;
        maxY.value = highestBookingCount;
      } else {
        Get.snackbar('Error', 'Failed to fetch chart data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    } finally {
      isLoadingChart(false);
    }
  }

  Color getColorForService(int serviceId) {
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
    urlImageBanners();
    fetchChartData();

    if (controllerLogin.user.value?.idUsers.toString() != null) {
      assignTicketUser(controllerLogin.user.value?.idUsers.toString() ?? '');
      assignAllHistoryPesan(
          controllerLogin.user.value?.idUsers.toString() ?? '');
    }

    controllerLogin.user.listen((userModel) {
      if (userModel != null) {
        assignTicketUser(userModel.idUsers.toString());
        assignAllHistoryPesan(userModel.idUsers.toString());
      } else {
        ticketUser.clear();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationHelper.showNotification(
          message.notification?.title, message.notification?.body);
    });
  }
}
