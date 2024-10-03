import 'dart:convert';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/history_booking_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerStatusScreen extends GetxController {
  var isLoading = false.obs;
  var message = ''.obs;
  var idUsers = ''.obs;
  var historyPesan = <HistoryBookingModel>[].obs;
  var historyProses = <HistoryBookingModel>[].obs;
  var historySelesai = <HistoryBookingModel>[].obs;
  var historyTolak = <HistoryBookingModel>[].obs;

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
    isLoading(true);
    try {
      final response = await http.post(Uri.parse('${apiService}updateBooking'),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({'id_booking': idBooking}));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        Get.toNamed(Routes.doneUpdateStatusScreen);
        // print(Routes.doneUpdateStatusScreen);
      } else {
        snackBarError("Gagal", "ada sesuatu yang error");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void assignAllHistoryPesan(String idUser) async {
    try {
      isLoading(true);
      var historyPesanList = await fetchHistory(idUser, 'dipesan');
      if (historyPesanList.isNotEmpty) {
        historyPesan.assignAll(historyPesanList);
      }
    } finally {
      isLoading(false);
    }
  }

  void assignAllHistoryProses(String idUser) async {
    try {
      isLoading(true);
      var historyProsesList = await fetchHistory(idUser, 'diproses');
      if (historyProsesList.isNotEmpty) {
        historyProses.assignAll(historyProsesList);
      }
    } finally {
      isLoading(false);
    }
  }

  void assignHistoryDitolak(String idUser) async {
    try {
      isLoading(true);
      var historyDitolakList = await fetchHistory(idUser, 'dibatalkan');
      if (historyDitolakList.isNotEmpty) {
        historyTolak.assignAll(historyDitolakList);
      }
    } finally {
      isLoading(false);
    }
  }

  void assignHistorySelesai(String idUser) async {
    try {
      isLoading(true);
      var historySelesaiList = await fetchHistory(idUser, 'selesai');
      if (historySelesaiList.isNotEmpty) {
        historySelesai.assignAll(historySelesaiList);
      }
    } finally {
      isLoading(false);
    }
  }
}
