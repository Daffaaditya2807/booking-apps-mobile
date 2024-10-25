import 'dart:convert';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/history_booking_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/service_model.dart';
import 'controller_get_service.dart';

class ControllerStatusScreen extends GetxController {
  var isLoading = false.obs;
  var isLoadingSelesai = false.obs;
  var isLoadingPesan = false.obs;
  var isLoadingProses = false.obs;
  var isLoadingTolak = false.obs;
  var message = ''.obs;
  var idUsers = ''.obs;
  var valueDateFilter = ''.obs;
  var statusPesanan = ''.obs;
  var activeTabIndex = 0.obs; // Track active tab index
  var historyPesan = <HistoryBookingModel>[].obs;
  var historyProses = <HistoryBookingModel>[].obs;
  var historySelesai = <HistoryBookingModel>[].obs;
  var historyTolak = <HistoryBookingModel>[].obs;
  final _originalHistoryPesan = <HistoryBookingModel>[].obs;
  final _originalHistoryProses = <HistoryBookingModel>[].obs;
  final _originalHistorySelesai = <HistoryBookingModel>[].obs;
  final _originalHistoryTolak = <HistoryBookingModel>[].obs;
  var profileModel = Rxn<ProfileModel>();
  var getServiceList = <ServiceModel>[].obs;
  var selectedServices = <bool>[].obs;
  var selectedIndex = (-1).obs;

  // Mont Picker Data
  final DateTime firstDate = DateTime.now().subtract(const Duration(days: 350));
  final DateTime lastDate = DateTime.now().add(const Duration(days: 350));
  var selectedDate = DateTime.now().obs;
  void onSelectedDateChanged(DateTime newDate) {
    selectedDate.value = newDate;
    valueDateFilter.value = convMonthYear(selectedDate.value.toString());
  }

  //Date Picker Range Data
  Rx<DatePeriod> selectedPeriod = Rx<DatePeriod>(
    DatePeriod(
      DateTime.now().subtract(const Duration(days: 0)),
      DateTime.now().add(const Duration(days: 0)),
    ),
  );

  DatePeriod get getSelectedPeriod => selectedPeriod.value;
  void onSelectedDateChangedRange(DatePeriod newPeriod) {
    selectedPeriod.value = newPeriod;
    valueDateFilter.value =
        "${convDate(selectedPeriod.value.start.toString())} - ${convDate(selectedPeriod.value.end.toString())}";
    update();
  }

  final DatabaseReference _bookingRef =
      FirebaseDatabase.instance.ref('booking');
  final ControllerGetService controllerGetService =
      Get.put(ControllerGetService());

  void selectButton(int index) {
    selectedIndex.value = index;
  }

  String convMonthYear(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formatedDate = DateFormat('MMMM yyyy').format(dateTime);
    return formatedDate;
  }

  String convDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formatedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formatedDate;
  }

  void listenForBookingUpdates() {
    _bookingRef
        .orderByChild('updated_at')
        .limitToLast(1)
        .onValue
        .listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        try {
          final entry = data.entries.firstWhere(
            (entry) =>
                (entry.value as Map<dynamic, dynamic>)['id_users'] ==
                idUsers.value,
          );

          final booking = entry.value as Map<dynamic, dynamic>;
          String idUser = booking['id_users'];
          print(
              "ID USER STATUS SCREEN == $idUser dan ID USER ${idUsers.value}");

          assignAllHistoryPesan(idUsers.value);
          assignAllHistoryProses(idUsers.value);
          assignHistorySelesai(idUsers.value);
          assignHistoryDitolak(idUsers.value);
          String statusPesananUser = booking['status'];
          print("STATUS = $statusPesananUser");
          statusPesanan.value = statusPesananUser;

          if (booking['status'] == 'selesai') {
            String bookingId = booking['id_booking'];
            deleteBookingById(bookingId);
          }
        } catch (e) {
          // Tidak ditemukan data yang sesuai
          print("Tidak ada data booking yang sesuai");
        }
      }
    });
  }

  void deleteBookingById(String bookingId) async {
    try {
      await _bookingRef
          .child(bookingId)
          .remove(); // Hapus node berdasarkan `id_booking`
      print('Booking with id $bookingId has been removed.');
    } catch (e) {
      print('Error deleting booking with id $bookingId: $e');
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
        _originalHistoryPesan.assignAll(historyPesanList);
        historyPesan.assignAll(historyPesanList);
      } else {
        _originalHistoryPesan.clear();
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
        _originalHistoryProses.assignAll(historyProsesList);
        historyProses.assignAll(historyProsesList);
      } else {
        _originalHistoryProses.clear();
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
        _originalHistoryTolak.assignAll(historyDitolakList);
        historyTolak.assignAll(historyDitolakList);
      } else {
        _originalHistoryTolak.clear();
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
        _originalHistorySelesai.assignAll(historySelesaiList);
        historySelesai.assignAll(historySelesaiList);
      } else {
        _originalHistorySelesai.clear();
        historySelesai.clear();
      }
    } finally {
      isLoadingSelesai(false);
      historySelesai.refresh();
    }
  }

  List<ServiceModel> getSelectedServices() {
    return [
      for (int i = 0; i < getServiceList.length; i++)
        if (selectedServices[i]) getServiceList[i]
    ];
  }

  void assignServiceLits() async {
    try {
      var getService = await controllerGetService.fetchService();

      if (getService.isNotEmpty) {
        getServiceList.assignAll(getService);
        selectedServices
            .assignAll(List.generate(getServiceList.length, (_) => false));
      } else {
        getServiceList.clear();
        selectedServices.clear();
      }
    } finally {}
  }

  void filterHistoryData(
      List<ServiceModel> selectedServices, String dateFilter) {
    try {
      // Reset to original data first based on active tab
      switch (activeTabIndex.value) {
        case 0:
          historyPesan.assignAll(_originalHistoryPesan);
          break;
        case 1:
          historyProses.assignAll(_originalHistoryProses);
          break;
        case 2:
          historyTolak.assignAll(_originalHistoryTolak);
          break;
        case 3:
          historySelesai.assignAll(_originalHistorySelesai);
          break;
      }

      // Filter based on selected services
      if (selectedServices.isNotEmpty) {
        final selectedServiceIds = selectedServices.map((e) => e.id).toList();

        void filterByService(RxList<HistoryBookingModel> list) {
          list.value = list
              .where((history) =>
                  selectedServiceIds.contains(int.parse(history.idLayanan)))
              .toList();
        }

        // Only filter active tab's data
        switch (activeTabIndex.value) {
          case 0:
            filterByService(historyPesan);
            break;
          case 1:
            filterByService(historyProses);
            break;
          case 2:
            filterByService(historyTolak);
            break;
          case 3:
            filterByService(historySelesai);
            break;
        }
      }

      // Sort data based on date
      void sortList(RxList<HistoryBookingModel> list, bool isNewest) {
        if (list.isNotEmpty) {
          list.sort((a, b) {
            if (isNewest) {
              return b.createdAt.compareTo(a.createdAt);
            } else {
              return a.createdAt.compareTo(b.createdAt);
            }
          });
          list.refresh();
        }
      }

      // Apply sorting based on selectedIndex for active tab only
      if (selectedIndex.value == 0 || selectedIndex.value == 1) {
        bool isNewest = selectedIndex.value == 0;
        switch (activeTabIndex.value) {
          case 0:
            sortList(historyPesan, isNewest);
            break;
          case 1:
            sortList(historyProses, isNewest);
            break;
          case 2:
            sortList(historyTolak, isNewest);
            break;
          case 3:
            sortList(historySelesai, isNewest);
            break;
        }
      }

      // Filter by date if applicable
      if (dateFilter.isNotEmpty &&
          !dateFilter.contains('Data') &&
          selectedIndex.value >= 2) {
        // Monthly filter
        if (!dateFilter.contains('-')) {
          final filterDate = DateFormat('MMMM yyyy').parse(dateFilter);

          void filterByMonth(RxList<HistoryBookingModel> list) {
            list.value = list.where((history) {
              final historyDate = DateTime.parse(history.tanggal);
              return historyDate.month == filterDate.month &&
                  historyDate.year == filterDate.year;
            }).toList();
          }

          // Only filter active tab's data
          switch (activeTabIndex.value) {
            case 0:
              filterByMonth(historyPesan);
              break;
            case 1:
              filterByMonth(historyProses);
              break;
            case 2:
              filterByMonth(historyTolak);
              break;
            case 3:
              filterByMonth(historySelesai);
              break;
          }
        }
        // Date range filter
        else {
          final dates = dateFilter.split(' - ');
          final startDate = DateFormat('dd MMMM yyyy').parse(dates[0]);
          final endDate = DateFormat('dd MMMM yyyy').parse(dates[1]);

          void filterByDateRange(RxList<HistoryBookingModel> list) {
            list.value = list.where((history) {
              final historyDate = DateTime.parse(history.tanggal);
              return historyDate
                      .isAfter(startDate.subtract(Duration(days: 1))) &&
                  historyDate.isBefore(endDate.add(Duration(days: 1)));
            }).toList();
          }

          // Only filter active tab's data
          switch (activeTabIndex.value) {
            case 0:
              filterByDateRange(historyPesan);
              break;
            case 1:
              filterByDateRange(historyProses);
              break;
            case 2:
              filterByDateRange(historyTolak);
              break;
            case 3:
              filterByDateRange(historySelesai);
              break;
          }
        }
      }
    } catch (e) {
      print("Error filtering data: $e");
      resetFilter();
    }
  }

  void resetFilter() {
    // Reset semua filter
    selectedServices
        .assignAll(List.generate(getServiceList.length, (_) => false));
    selectedIndex.value = (-1);
    valueDateFilter.value = '';

    // Reset data sesuai tab aktif
    switch (activeTabIndex.value) {
      case 0:
        assignAllHistoryPesan(idUsers.value);
        break;
      case 1:
        assignAllHistoryProses(idUsers.value);
        break;
      case 2:
        assignHistoryDitolak(idUsers.value);
        break;
      case 3:
        assignHistorySelesai(idUsers.value);
        break;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenForBookingUpdates();
    getProfileModel();
    assignServiceLits();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _bookingRef.onDisconnect();
    statusPesanan.value = '';
    super.onClose();
  }
}
