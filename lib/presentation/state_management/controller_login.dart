import 'dart:convert';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/user_model.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ControllerLogin extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var errorMessage = ''.obs;

  Future<bool> login(String username, String password) async {
    isLoading.value = true;

    try {
      final response = await http.post(Uri.parse('${apiService}login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': username, 'password': password}));

      final responseBody = json.decode(response.body);
      int code = responseBody['meta']['code'];
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
      }
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
      snackBarSucces("Kolom password kosong", "harap mengisi kolom password");
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserFromPrefs();
  }
}
