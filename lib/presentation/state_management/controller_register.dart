import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/user_model.dart';
import 'package:apllication_book_now/presentation/state_management/controller_dicebear.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../data/data_sources/notification_helper.dart';

class ControllerRegister extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var errorMessahe = ''.obs;
  var deviceToken = ''.obs;
  final DiceBearController diceBearController = Get.put(DiceBearController());
  NotificationHelper notificationHelper = NotificationHelper();

  @override
  void onInit() {
    super.onInit();
    diceBearController.fetchRandomAvatar();
    notificationHelper.requestPermission();
    getToken();
  }

  Future<void> getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    deviceToken.value = token.toString();
    print("token ${deviceToken.value}");
  }

  Future<void> register(String name, String email, String username,
      String password, String phone) async {
    isLoading.value = true;
    print("token ${deviceToken.value}");
    try {
      final response = await http.post(Uri.parse('${apiService}register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nama_pembeli': name,
            'email': email,
            'username': username,
            'password': password,
            'phone_number': phone,
            'phone_token': deviceToken.value,
            'avatar': diceBearController.avatarUrl.value
          }));

      final responseBody = json.decode(response.body);
      print(responseBody);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        if (responseBody['meta']['status'] == 'success') {
          user.value = UserModel.fromJson(responseBody['data']['user']);
          errorMessahe.value = '';
          Get.offNamed(Routes.otpInputScreen, arguments: {
            'email': email.toString(),
            'name': name.toString(),
            'id_user': user.value!.idUsers.toString(),
            'page': 'register'
          });
        } else if (code == 500) {
          errorMessahe.value =
              'failed to register. with error ${response.statusCode}';
          snackBarError("Gagal Register",
              "Terjadi kesalahan saat melakukan pendaftaran akun");
        }
      } else if (code == 400) {
        snackBarError("Gagal Register", "Username telah tersedia");
      } else if (code == 401) {
        snackBarError("Gagal Register", "Email telah tersedia");
      }
    } on SocketException {
      snackBarError("Gagal Login", "Periksa koneksi internet anda");
    } catch (e) {
      errorMessahe.value = 'Error: ${e}';
    } finally {
      isLoading.value = false;
    }
  }

  bool checkDataNullRegister(String name, String email, String username,
      String password, String confirmPassword, String noTelpon) {
    if (name.isEmpty) {
      snackBarError("Kolom nama Kosong", "Harap mengisi kolom nama");
      return true;
    }

    if (email.isEmpty) {
      snackBarError("Kolom email Kosong", "Harap mengisi kolom email");
    }

    if (username.isEmpty) {
      snackBarError("Kolom username Kosong", "Harap mengisi kolom username");
      return true;
    }

    if (password.isEmpty) {
      snackBarError("Kolom password Kosong", "Harap mengisi kolom password");
      return true;
    }

    if (confirmPassword.isEmpty) {
      snackBarError("Kolom konfirmasi password Kosong",
          "Harap mengisi kolom konfirmasi password");
      return true;
    }

    if (noTelpon.isEmpty) {
      snackBarError(
          "Kolom nomor telepon Kosong", "Harap mengisi kolom nomor telepon");
      return true;
    }

    if (noTelpon.length < 10) {
      snackBarError("Nomor telepon tidak valid",
          "Mohon periksa kembali nomor telepon yang dimasukkan apakah sesuai");
      return true;
    } else {
      String? phoneValidate = validateIndonesianPhone(noTelpon);
      if (phoneValidate != null) {
        snackBarError("Nomor telepon tidak valid", phoneValidate);
        return true;
      }
    }

    if (password != confirmPassword) {
      snackBarError("Password tidak sama", "Harap periksa password kembali");
      return true;
    }

    return false;
  }

  String? validateIndonesianPhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    // Hapus semua spasi dan karakter non-digit
    phone = phone.replaceAll(RegExp(r'\s+'), '');

    // Regular expression untuk format nomor Indonesia
    final RegExp indonesianPhoneRegex =
        RegExp(r'^(?:(?:\+|62|0)(?:\d{9,15}))$');

    // Cek panjang minimal dan maksimal
    if (phone.length < 9 || phone.length > 15) {
      return 'Nomor telepon harus antara 9-15 digit';
    }

    // Cek format nomor Indonesia
    if (!indonesianPhoneRegex.hasMatch(phone)) {
      return 'Format nomor telepon tidak valid';
    }
    return null;
  }
}
