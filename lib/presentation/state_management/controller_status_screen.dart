import 'dart:convert';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/history_booking_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../data/models/profile_model.dart';
import 'controller_dashboard.dart';

class ControllerStatusScreen extends GetxController {
  var isLoading = false.obs;
  var isLoadingSelesai = false.obs;
  var isLoadingPesan = false.obs;
  var isLoadingProses = false.obs;
  var isLoadingTolak = false.obs;
  var message = ''.obs;
  var idUsers = ''.obs;
  var historyPesan = <HistoryBookingModel>[].obs;
  var historyProses = <HistoryBookingModel>[].obs;
  var historySelesai = <HistoryBookingModel>[].obs;
  var historyTolak = <HistoryBookingModel>[].obs;
  late PusherChannelsFlutter pusher;
  var profileModel = Rxn<ProfileModel>();

  Future<void> initPusher() async {
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
          // print("Data Update SCREEN STATUS ${event.data}");
          // print("Tes Data ${event.eventName} and ${event.channelName}");
          var eventData = jsonDecode(event.data);
          String eventUserId = eventData['id_users'];
          if (eventUserId == idUsers.value) {
            assignAllHistoryPesan(idUsers.value);
            assignAllHistoryProses(idUsers.value);
            assignHistorySelesai(idUsers.value);
            assignHistoryDitolak(idUsers.value);
            ControllerDashboard controllerDashboard =
                Get.find<ControllerDashboard>();
            controllerDashboard.assignAllHistoryLast(idUsers.value);
          } else {
            print("Event diterima untuk user lain, tidak memperbarui data");
          }
        },
      );
      await pusher.connect();
      await pusher.subscribe(channelName: "booking-channel");
    } catch (e) {
      print("Error initializing Pusher : $e");
    }
  }

  Future<ProfileModel> getProfileModel() async {
    try {
      final response = await http.get(
        Uri.parse('${apiService}getprofile'),
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        var dataProfile = jsonDecode(response.body)['data']['data'];
        return profileModel.value = ProfileModel.fromJson(dataProfile);
      } else {
        return Future.error("Failed to retrive");
      }
    } catch (e) {
      print(e.toString());
      return Future.error("Error: $e");
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

  Future<void> updateStatusProsesUser(String idBooking) async {
    // isLoading(true);
    try {
      final response = await http.post(Uri.parse('${apiService}updateBooking'),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({'id_booking': idBooking}));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        Get.toNamed(Routes.doneUpdateStatusScreen);
      } else {
        snackBarError("Gagal", "ada sesuatu yang error");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      // isLoading(false);
    }
  }

  void assignAllHistoryPesan(String idUser) async {
    try {
      isLoadingPesan(true);
      var historyPesanList = await fetchHistory(idUser, 'dipesan');
      if (historyPesanList.isNotEmpty) {
        historyPesan.assignAll(historyPesanList);
      } else {
        historyPesan.clear();
      }
    } finally {
      isLoadingPesan(false);
      historyPesan.refresh();
    }
  }

  void assignAllHistoryProses(String idUser) async {
    try {
      isLoadingProses(true);
      var historyProsesList = await fetchHistory(idUser, 'diproses');
      if (historyProsesList.isNotEmpty) {
        historyProses.assignAll(historyProsesList);
      } else {
        historyProses.clear();
      }
    } finally {
      isLoadingProses(false);
      historyProses.refresh();
    }
  }

  void assignHistoryDitolak(String idUser) async {
    try {
      isLoadingTolak(true);
      var historyDitolakList = await fetchHistory(idUser, 'dibatalkan');
      if (historyDitolakList.isNotEmpty) {
        historyTolak.assignAll(historyDitolakList);
      } else {
        historyTolak.clear();
      }
    } finally {
      isLoadingTolak(false);
      historyTolak.refresh();
    }
  }

  void assignHistorySelesai(String idUser) async {
    try {
      isLoadingSelesai(true);
      var historySelesaiList = await fetchHistory(idUser, 'selesai');
      if (historySelesaiList.isNotEmpty) {
        historySelesai.assignAll(historySelesaiList);
      } else {
        historySelesai.clear();
      }
    } finally {
      isLoadingSelesai(false);
      historySelesai.refresh();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initPusher();
    getProfileModel();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // pusher.disconnect();
    super.onClose();
  }
}
