import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/api.dart';
import '../../data/models/history_booking_model.dart';

class ControllerDashboard extends GetxController {
  RxInt currentIndex = 0.obs;
  var isLoading = false.obs;
  var message = ''.obs;
  var idUsers = ''.obs;
  var ticketUser = <HistoryBookingModel>[].obs;

  void getIndex(int current) {
    currentIndex.value = current;
  }

  Future<List<HistoryBookingModel>> fetchGetTicketUser(String idUser) async {
    try {
      final response = await http.post(Uri.parse('${apiService}getTicketUser'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'id_users': idUser}));

      final responseBody = json.decode(response.body);
      print(responseBody);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        var data = jsonDecode(response.body)['data'];
        List<HistoryBookingModel> getTicketUser =
            List<HistoryBookingModel>.from(
                data.map((i) => HistoryBookingModel.fromJson(i)));
        return getTicketUser;
      } else if (code == 404) {
        message.value = "tidak ada ticket booking";
        return [];
      } else {
        message.value = "Failed to load ticket booking";
        return [];
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }

  void assignTicketUser(String idUser) async {
    try {
      isLoading(true);
      var getTicketUser = await fetchGetTicketUser(idUser);
      if (getTicketUser.isNotEmpty) {
        ticketUser.assignAll(getTicketUser);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    assignTicketUser('3');
  }
}
