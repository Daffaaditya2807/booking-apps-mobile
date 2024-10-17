import 'dart:convert';
import 'dart:math';

import 'package:apllication_book_now/data/data_sources/notification_helper.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../data/data_sources/api.dart';

import '../../data/models/history_booking_model.dart';

class ControllerDashboard extends GetxController {
  RxInt currentIndex = 0.obs;
  var isLoading = false.obs;
  var isLoadingChart = false.obs;
  var isLoadingHistory = false.obs;
  var message = ''.obs;
  var idUsers = ''.obs;
  var ticketUser = <HistoryBookingModel>[].obs;
  var barGroups = <BarChartGroupData>[].obs;
  var jamLayanan = <String>[].obs;
  var namaLayanan = <String>[].obs;
  var layanan = <Map<String, dynamic>>[].obs;
  var maxY = 0.0.obs;
  var historyLast = <HistoryBookingModel>[].obs;
  late PusherChannelsFlutter pusher;
  List urlImagee = [].obs;
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());

  NotificationHelper notificationHelper = NotificationHelper();

  void getIndex(int current) {
    currentIndex.value = current;
  }

  Future<void> initPusher(String idUser) async {
    pusher = PusherChannelsFlutter();
    try {
      await pusher.init(
        apiKey: "e8dd0273a5e8de2d483b",
        cluster: "ap1",
        onConnectionStateChange: (currentState, previousState) {
          print("Connection State Status Screen: $currentState");
        },
        onError: (message, code, error) {
          print("Pusher Error : $message");
        },
        onEvent: (PusherEvent event) {
          // print("Data Update SCREEN DASHBOARD ${event.data}");
          // print("Tes Data ${event.eventName} and ${event.channelName}");

          var eventData = jsonDecode(event.data);
          String eventUserId = eventData['id_users'];
          if (eventUserId == idUser) {
            assignAllHistoryLast(idUser);
            final ControllerStatusScreen controllerStatusScreen =
                Get.find<ControllerStatusScreen>();
            controllerStatusScreen.assignAllHistoryPesan(idUser);
            controllerStatusScreen.assignAllHistoryProses(idUser);
            controllerStatusScreen.assignHistorySelesai(idUser);
            controllerStatusScreen.assignHistoryDitolak(idUser);
          } else {
            print("Event diterima untuk user lain, tidak memperbarui data");
          }
        },
      );
      await pusher.connect();
      await pusher.subscribe(channelName: "history-channel");
    } catch (e) {
      print("Error initializing Pusher : $e");
    }
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

  Future<List<HistoryBookingModel>> fetchHistoryLast(String idUser) async {
    try {
      final response = await http.post(
          Uri.parse('${apiService}getlasthistorybooking'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'id_users': idUser}));

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

  void assignAllHistoryLast(String idUser) async {
    isLoadingHistory(true);
    try {
      var historyPesanList = await fetchHistoryLast(idUser);
      if (historyPesanList.isNotEmpty) {
        historyLast.assignAll(historyPesanList);
      }
    } finally {
      isLoadingHistory(false);
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
      assignAllHistoryLast(
          controllerLogin.user.value?.idUsers.toString() ?? '');
      initPusher(controllerLogin.user.value!.idUsers.toString());
      // PusherService.instance.initPusher(
      //     controllerLogin.user.value!.idUsers.toString(), (PusherEvent event) {
      //   print("Data Update ${event.data}");
      //   var eventData = jsonDecode(event.data);
      //   String eventUserId = eventData['id_users'];
      //   if (eventUserId == controllerLogin.user.value!.idUsers.toString()) {
      //     assignAllHistoryLast(idUsers.value);
      //   }
      // }, "history-channel");
    }

    controllerLogin.user.listen((userModel) {
      if (userModel != null) {
        assignTicketUser(userModel.idUsers.toString());
        assignAllHistoryLast(userModel.idUsers.toString());
        initPusher(userModel.idUsers.toString());
        // PusherService.instance.initPusher(userModel.idUsers.toString(),
        //     (PusherEvent event) {
        //   print("Data Update ${event.data}");
        //   var eventData = jsonDecode(event.data);
        //   String eventUserId = eventData['id_users'];
        //   if (eventUserId == userModel.idUsers.toString()) {
        //     assignAllHistoryLast(idUsers.value);
        //   }
        // }, "history-channel");
      } else {
        ticketUser.clear();
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationHelper.showNotification(
          message.notification?.title, message.notification?.body);
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pusher.disconnect();
  }
}
