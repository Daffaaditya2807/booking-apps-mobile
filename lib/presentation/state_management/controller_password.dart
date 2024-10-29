import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerPassword extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> updatePassword(String idUser, String oldPassword,
      String newPassword, String confirmPassword) async {
    isLoading(true);
    if (newPassword == confirmPassword) {
      try {
        final response = await http.post(
            Uri.parse('${apiService}change_password'),
            headers: {
              'Content-type': 'application/json',
            },
            body: jsonEncode({
              'id_users': idUser,
              'old_password': oldPassword,
              'new_password': newPassword
            }));
        final responseBody = json.decode(response.body);
        int code = responseBody['meta']['code'];
        if (code == 200) {
          errorMessage.value = '';
          snackBarSucces(
              "Password Berhasil Diubah", "Password anda berhasil diubah");
          return true;
        } else if (code == 401) {
          errorMessage.value = "Password lama tidak sesuai";
          snackBarError("Error", errorMessage.value);
          return false;
        } else if (code == 500) {
          errorMessage.value = "Password gagal diubah";
          snackBarError("Error", errorMessage.value);
          return false;
        }
      } on SocketException {
        snackBarError(
            "Gagal Mengubah Password", "Periksa koneksi internet anda");
      } catch (e) {
        errorMessage.value = 'Error: $e';
        snackBarError("Error", errorMessage.value);
        return false;
      } finally {
        isLoading.value = false;
      }
    } else {
      snackBarError("Password tidak sama",
          "Harap periksa kembali password baru yang telah dimasukkan");
      isLoading(false);
      return false;
    }
    return false;
  }

  bool checkDataPassword(
      String password, String newPassword, String confirmPassword) {
    if (password.isEmpty) {
      snackBarError(
          "Kolom password lama kosong", "harap mengisi kolom password lama");
      return true;
    } else if (newPassword.isEmpty) {
      snackBarError(
          "kolom password baru kosong", "harap mengisi password baru");
      return true;
    } else if (confirmPassword.isEmpty) {
      snackBarError("kolom konfirmasi password baru kosong",
          "harap mengisi konfirmasi password baru");
      return true;
    }
    return false;
  }

  bool validatePassword(BuildContext context, String password) {
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasMinLength = password.length > 7;

    if (!hasUpperCase || !hasNumber || !hasMinLength) {
      String errorMessage = 'Password harus:\n';
      if (!hasMinLength) errorMessage += '- Minimal 8 karakter\n';
      if (!hasUpperCase) errorMessage += '- Mengandung minimal 1 huruf besar\n';
      if (!hasNumber) errorMessage += '- Mengandung minimal 1 angka';
      snackBarError("Gagal Mengubah Password", errorMessage);
      return false;
    } else {
      return true;
    }
  }
}
