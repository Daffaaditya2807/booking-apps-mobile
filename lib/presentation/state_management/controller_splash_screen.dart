import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/data_sources/notification_helper.dart';
import 'package:apllication_book_now/data/models/profile_model.dart';
import 'package:apllication_book_now/presentation/state_management/controller_connection.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ControllerSplashScreen extends GetxController {
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());
  final ControllerConnection controllerConnection =
      Get.put(ControllerConnection());
  NotificationHelper notificationHelper = NotificationHelper();
  var profileModel = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    // initializeSplashScreen();
    controllerLogin.getToken();
    controllerConnection.listenConnectivity(
      onConnected: () {
        if (controllerConnection.isConnected.value == true) {
          print("object");
          initializeSplashScreen();
        }
      },
    );
  }

  Future<void> initializeSplashScreen() async {
    controllerLogin.loadUserFromPrefs();
    notificationHelper.requestNotificationPermission();

    // Only proceed with token validation if user data exists
    if (controllerLogin.user.value != null) {
      final isSessionValid = await validateUserSession();
      if (!isSessionValid) {
        await handleInvalidSession();
        await getProfileModel();
        await navigateToLogin();
        return;
      }
    }

    // Tunggu hingga profileModel selesai diload sebelum melanjutkan
    await getProfileModel();
    await navigateSplashScreen();
  }

  Future<bool> validateUserSession() async {
    try {
      if (controllerLogin.user.value == null) return false;

      final deviceToken = await getDeviceToken();
      final userId = controllerLogin.user.value!.idUsers;

      final response = await http.post(
        Uri.parse('${apiService}validate-session'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'device_token': deviceToken,
          'phone_token': controllerLogin.phoneToken.value,
        }),
      );

      final responseBody = json.decode(response.body);
      return responseBody['meta']['code'] == 200;
    } catch (e) {
      print('Session validation error: $e');
      return false;
    }
  }

  Future<String> getDeviceToken() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceToken;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceToken = iosInfo.identifierForVendor!;
    } else {
      deviceToken = 'unknown_device';
    }

    return deviceToken;
  }

  Future<void> handleInvalidSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    controllerLogin.user.value = null;
  }

  Future<void> navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.offNamed(Routes.introductionFirst);
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
    } on SocketException {
      return Future.error("Error: koneksi internet tidak ada");
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controllerConnection.connectivitySubscription?.cancel();
  }
}
