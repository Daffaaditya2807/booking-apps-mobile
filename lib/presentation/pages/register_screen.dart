import 'package:apllication_book_now/presentation/state_management/controller_register.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/presentation/widgets/list_textfield.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../state_management/controller_show_hide.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final TextEditingController _noTelpon = TextEditingController();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageRegister(context),
    );
  }

  SafeArea _buildPageRegister(BuildContext context) {
    final ShowHidePassword controllerShowHide = Get.put(ShowHidePassword());
    final ControllerRegister controllerRegister = Get.put(ControllerRegister());
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          componenTextHeaderDesc(
              "Buat Akun", "Silakan masukkan data diri anda"),
          spaceHeightBig,
          textFieldInput("Nama Lengkap", "Nama Lengkap", _nama, context),
          textFieldInput("Username", "Username", _username, context),
          Obx(() => textFieldPassword(
              "Password",
              "Password",
              controllerShowHide.isShow.value,
              _password,
              context,
              controllerShowHide.isShow.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              controllerShowHide.showHidePassword)),
          Obx(() => textFieldPassword(
              "Konfirmasi Password",
              "Konfirmasi Password",
              controllerShowHide.isShow.value,
              _confirmpassword,
              context,
              controllerShowHide.isShow.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              controllerShowHide.showHidePassword)),
          textFieldInput("Nomor Telepon", "Nomor Telepon", _noTelpon, context),
          spaceHeightMedium,
          buttonPrimary("Daftar", () {
            controllerRegister.checkDataNullRegister(_nama.text, _username.text,
                _password.text, _confirmpassword.text, _noTelpon.text);
          }),
          Expanded(child: Container()),
          Center(
            child: componenRichTextStyle("Sudah Punya Akun? ", "Masuk", () {
              Get.offNamed(Routes.loginScreen);
            }),
          ),
          spaceHeightMedium
        ],
      ),
    ));
  }
}
