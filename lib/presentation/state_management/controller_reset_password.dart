import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/state_management/controller_password.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerResetPassword extends GetxController {
  var isLoading = false.obs;
  final ControllerPassword controllerPassword = Get.put(ControllerPassword());

  Future<void> resetPassword(String email, String newPassword,
      String confirmPassword, BuildContext context) async {
    isLoading(true);
    if (newPassword == confirmPassword) {
      bool passwordValidate =
          controllerPassword.validatePassword(context, confirmPassword);
      if (passwordValidate) {
        try {
          final response = await http.post(
              Uri.parse('${apiService}forgetpassword'),
              headers: {'Content-type': 'application/json'},
              body: jsonEncode({'email': email, 'new_password': newPassword}));

          final responseBody = json.decode(response.body);
          int code = responseBody['meta']['code'];

          if (code == 200) {
            Get.offAllNamed(Routes.loginScreen);
          } else {
            snackBarError(
                "Gagal Reset Password", "terjadi error saat merubah password");
          }
        } on SocketException {
          snackBarError(
              "Gagal mereset password anda", "Periksa koneksi internet anda");
        } catch (e) {
          print(e.toString());
        } finally {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    } else {
      isLoading(false);
      snackBarError("Gagal Update Password",
          "Password baru dan konfirmasi password tidak sama! Harap periksa");
    }
  }
}
