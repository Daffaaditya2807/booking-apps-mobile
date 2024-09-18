import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:get/get.dart';

class ControllerRegister extends GetxController {
  void checkDataNullRegister(
      String name, username, password, confirmPassword, noTelpon) {
    if (name.isEmpty) {
      snackBarError("Kolom nama Kosong", "Harap mengisi kolom nama");
    } else if (username.toString().isEmpty) {
      snackBarError("Kolom username Kosong", "Harap mengisi kolom username");
    } else if (password.toString().isEmpty) {
      snackBarError("Kolom password Kosong", "Harap mengisi kolom password");
    } else if (confirmPassword.toString().isEmpty) {
      snackBarError("Kolom konfirmasi password Kosong",
          "Harap mengisi kolom konfirmasi password");
    } else if (noTelpon.toString().isEmpty) {
      snackBarError(
          "Kolom nomer telepon Kosong", "Harap mengisi kolom nomer telepon");
    } else if (password.toString() != confirmPassword.toString()) {
      snackBarError("Password tidak sama", "harap periksa password kembali");
    }
  }

  void passwordSame(String passwordFirst, String passwordLast) {
    if (passwordFirst != passwordLast) {
      snackBarError("Password tidak sama", "harap periksa password kembali");
    }
  }
}
