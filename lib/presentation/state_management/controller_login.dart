import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/user_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/routes.dart';

class ControllerLogin extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var errorMessage = ''.obs;
  var phoneToken = ''.obs;

  // Stream for handling force logout
  final _forceLogoutController = StreamController<bool>.broadcast();
  Stream<bool> get forceLogoutStream => _forceLogoutController.stream;

  // Setup Firebase messaging listener
  Future<void> setupMessageListener() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] == 'force_logout') {
        handleForceLogout();
      }
    });
  }

  // Handle force logout
  void handleForceLogout() {
    _forceLogoutController.add(true);
    clearUserData();
    Get.offAllNamed(Routes.loginScreen);
    snackBarError(
        "Logged Out", "Your account has been logged in on another device");
  }

  Future<String> getDeviceToken() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceToken;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceToken = iosInfo.identifierForVendor!; // Unique ID on iOS
    } else {
      deviceToken = 'unknown_device';
    }

    return deviceToken;
  }

  Future<void> getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    phoneToken.value = token.toString();
    // print("token ${phoneToken.value}");
  }

  Future<bool> login(String username, String password) async {
    isLoading.value = true;

    try {
      String deviceToken = await getDeviceToken();
      print("DEVICE TOKEN = ${deviceToken}");
      final response = await http.post(Uri.parse('${apiService}login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'password': password,
            'device_token': deviceToken,
            'phone_token': phoneToken.value
          }));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      print("Code nya berapa $code");
      if (code == 200) {
        if (responseBody['meta']['status'] == 'success') {
          user.value = UserModel.fromJson(responseBody['data']['user']);
          await saveUserToPrefs(user.value!);
          errorMessage.value = '';
          return true;
        }
      } else if (code == 500) {
        errorMessage.value =
            'Failed to autheticate. Status code: ${response.statusCode}';
        snackBarError(
            "Gagal Login", "Harap periksa kembali username dan password!");
        return false;
      } else if (code == 403) {
        snackBarError("Gagal Login",
            "Akun yang digunakan sudah terdapat pada device lain!");
        return false;
      } else if (code == 505) {
        user.value = UserModel.fromJson(responseBody['data']['user']);
        Get.toNamed(Routes.otpInputScreen, arguments: {
          'email': user.value!.email,
          'name': user.value!.namaPembeli,
          'id_user': user.value!.idUsers.toString(),
          'page': 'register'
        });
        return false;
      }
    } on SocketException {
      snackBarError("Gagal Login", "Periksa koneksi internet anda");
    } catch (e) {
      errorMessage.value = 'Error: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  bool checkDataNull(String name, String password) {
    if (name.isEmpty) {
      snackBarError("Kolom nama kosong", "harap mengisi kolom nama");
      return true;
    } else if (password.isEmpty) {
      snackBarError("Kolom password kosong", "harap mengisi kolom password");
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveUserToPrefs(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(userModel.toJson());
    await prefs.setString('user', userJson);
  }

  Future<void> loadUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      user.value = UserModel.fromJson(json.decode(userJson));
    }
  }

  void updateUserData(UserModel? newUser) {
    if (newUser != null) {
      user.value = newUser;
      saveUserToPrefs(newUser);
    }
  }

  Future<void> logout(String idUser) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('${apiService}logout'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_users': idUser,
        }),
      );

      if (response.statusCode == 200) {
        clearUserData();
        Get.offAllNamed(Routes.loginScreen);
      } else {
        snackBarError("Logout Gagal", "Terjadi kesalahan saat logout.");
      }
    } catch (e) {
      snackBarError("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    user.value = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserFromPrefs();
    getToken();
    setupMessageListener();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _forceLogoutController.close();
    super.onClose();
  }
}
