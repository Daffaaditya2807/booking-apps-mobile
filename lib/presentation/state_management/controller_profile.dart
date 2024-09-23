import 'dart:convert';

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
    }

    return false;
  }
}
