import 'dart:convert';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/user_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ControllerRegister extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var errorMessahe = ''.obs;

  Future<void> register(String name, String email, String username,
      String password, String phone, String phoneToken) async {
    isLoading.value = true;

    try {
      final response = await http.post(Uri.parse('${apiService}register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nama_pembeli': name,
            'email': email,
            'username': username,
            'password': password,
            'phone_number': phone,
            'phone_token': phoneToken
          }));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];

      if (code == 200) {
        if (responseBody['meta']['status'] == 'success') {
          user.value = UserModel.fromJson(responseBody['data']['user']);
          errorMessahe.value = '';
          snackBarSucces("Berhasil Register", "yeyeye");
        } else if (code == 500) {
          errorMessahe.value =
              'failed to register. with error ${response.statusCode}';
          snackBarError("Gagal Register",
              "Terjadi kesalahan saat melakukan pendaftaran akun");
        }
      } else if (code == 500) {}
    } catch (e) {
      errorMessahe.value = 'Error: ${e}';
    } finally {
      print("p");
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
    }

    if (password != confirmPassword) {
      snackBarError("Password tidak sama", "Harap periksa password kembali");
      return true;
    }

    return false;
  }
}
