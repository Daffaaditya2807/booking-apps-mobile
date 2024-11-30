import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/user_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'controller_login.dart';

class ControllerProfile extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var errorMessage = ''.obs;

  Future<void> updateDataUser(
      String idUser, String newName, String newPhone) async {
    isLoading(true);
    try {
      final response = await http.post(Uri.parse('${apiService}update_profile'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'id_users': idUser,
            'nama_pembeli': newName,
            'phone_number': newPhone
          }));
      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        if (responseBody['meta']['status'] == 'success') {
          user.value = UserModel.fromJson(responseBody['data']['user']);
          errorMessage.value = '';
          final controllerLogin = Get.find<ControllerLogin>();
          controllerLogin.updateUserData(user.value);

          snackBarSucces("Berhasil", "Profil anda berhasil diupdate");
        }
      }
    } on SocketException {
      snackBarError("Gagal Mengubah Profil", "Periksa koneksi internet anda");
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  bool checkDataProfile(String nama, String noTelpon) {
    if (nama.isEmpty) {
      snackBarError("Kolom nama kosong", "harap mengisi kolom nama");
      return true;
    } else if (noTelpon.isEmpty) {
      snackBarError(
          "kolom nomor telepon kosong", "harap mengisi nomor telepon");
      return true;
    } else if (noTelpon.length < 10) {
      snackBarError("Nomor telepon tidak valid",
          "Mohon periksa kembali nomor telepon yang dimasukan apakah sesuai");
      return true;
    } else {
      String? phoneValidate = validateIndonesianPhone(noTelpon);
      if (phoneValidate != null) {
        snackBarError("Nomor telepon tidak valid", phoneValidate);
        return true;
      }
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

    // Cek awalan yang valid untuk Indonesia
    List<String> validPrefixes = [
      '0811', '0812', '0813', '0814', '0815', '0816', '0817', '0818',
      '0819', // Telkomsel
      '0851', '0852', '0853', '0855', '0856', '0857', '0858', // Indosat
      '0895', '0896', '0897', '0898', '0899', // Three
      '0881', '0882', '0883', '0884', '0885', '0886', '0887', '0888',
      '0889', // Smartfren
      '0821', '0822', '0823', '0851', '0852', '0853', // XL
      '0838', '0831', '0832', '0833', // Axis
    ];

    // Konversi nomor ke format 08xx
    String normalizedNumber = phone;
    if (phone.startsWith('+62')) {
      normalizedNumber = '0' + phone.substring(3);
    } else if (phone.startsWith('62')) {
      normalizedNumber = '0' + phone.substring(2);
    }

    // Cek apakah awalan valid
    bool hasValidPrefix = false;
    for (String prefix in validPrefixes) {
      if (normalizedNumber.startsWith(prefix)) {
        hasValidPrefix = true;
        break;
      }
    }

    if (!hasValidPrefix) {
      return 'Nomor provider tidak valid untuk Indonesia';
    }

    return null;
  }
}
