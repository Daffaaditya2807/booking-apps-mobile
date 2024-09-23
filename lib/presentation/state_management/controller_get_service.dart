import 'dart:convert';

import 'package:apllication_book_now/data/models/service_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/api.dart';

class ControllerGetService extends GetxController {
  var isLoading = true.obs;
  var serviceList = <ServiceModel>[].obs;

  Future<List<ServiceModel>> fetchService() async {
    try {
      final response = await http.get(Uri.parse('${apiService}allservice'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['data'];
        List<ServiceModel> services =
            List<ServiceModel>.from(data.map((i) => ServiceModel.fromJson(i)));
        return services;
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }

  void fetchServices() async {
    try {
      isLoading(true);
      var services = await fetchService();
      if (services.isNotEmpty) {
        serviceList.assignAll(services);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchServices();
  }
}
