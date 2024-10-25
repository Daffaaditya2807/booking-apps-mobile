import 'dart:convert';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/data_sources/notification_helper.dart';
import 'package:apllication_book_now/data/models/profile_model.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerSplashScreen extends GetxController {
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());
  NotificationHelper notificationHelper = NotificationHelper();
  var profileModel = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    initializeSplashScreen();
  }

  Future<void> initializeSplashScreen() async {
    controllerLogin.loadUserFromPrefs();
    notificationHelper.requestNotificationPermission();

    // Tunggu hingga profileModel selesai diload sebelum melanjutkan
    await getProfileModel();
    await navigateSplashScreen();
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

  ProfileModel? get profileOrDefault {
    return profileModel.value ??
        ProfileModel(id: 0, logo: '', namaUsaha: '', warna: '');
  }

  Future<void> navigateSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (controllerLogin.user.value != null) {
      Get.offNamed(Routes.navbarMenu);
    } else {
      Get.offNamed(Routes.introductionFirst);
    }
  }
}
