import 'dart:convert';
import 'dart:io';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/models/user_model.dart';

class ControllerForgetPassword extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  Future<void> checkUserAvailable(String email) async {
    isLoading(true);
    try {
      final response =
          await http.post(Uri.parse('${apiService}checkuseravailable'),
              headers: {
                'Content-type': 'application/json',
              },
              body: jsonEncode({'email': email.toString()}));

      final responseBody = json.decode(response.body);
      print(responseBody);
      int code = responseBody['meta']['code'];
      if (code == 200) {
        user.value = UserModel.fromJson(responseBody['data']['user']);

        Get.offNamed(Routes.otpInputScreen, arguments: {
          'email': user.value!.email,
          'name': user.value!.namaPembeli,
          'id_user': user.value!.idUsers.toString(),
          'page': 'lupa_sandi'
        });
      } else if (code == 404) {
        snackBarError("User tidak tersedia",
            "Tidak dapat melakukan reset password karena akun user tidak tersedia");
      }
    } on SocketException {
      snackBarError(
          "Gagal mendapatkan data user", "Periksa koneksi internet anda");
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
