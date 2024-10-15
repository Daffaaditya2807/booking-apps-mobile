import 'package:apllication_book_now/presentation/state_management/controller_register.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/presentation/widgets/list_textfield.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../state_management/controller_show_hide.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final ShowHidePassword controllerShowHide = Get.put(ShowHidePassword());
  final ControllerRegister controllerRegister = Get.put(ControllerRegister());

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final TextEditingController _noTelpon = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageRegister(context),
    );
  }

  SafeArea _buildPageRegister(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceHeightBig,
            componenTextHeaderDesc(
                "Buat Akun", "Silakan masukkan data diri anda"),
            spaceHeightBig,
            textFieldInput("Nama Lengkap", "Nama Lengkap", _nama, context,
                typeInput: TextInputType.name,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                ]),
            textFieldInput("Email", "Email", _email, context,
                typeInput: TextInputType.emailAddress,
                formatter: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ]),
            textFieldInput("Username", "Username", _username, context,
                typeInput: TextInputType.text,
                formatter: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ]),
            Obx(() => textFieldPassword(
                "Password",
                "Password",
                controllerShowHide.isShow.value,
                _password,
                context,
                controllerShowHide.isShow.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                controllerShowHide.showHidePassword,
                typeInput: TextInputType.text)),
            Obx(() => textFieldPassword(
                "Konfirmasi Password",
                "Konfirmasi Password",
                controllerShowHide.isShowConfirm.value,
                _confirmpassword,
                context,
                controllerShowHide.isShowConfirm.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                controllerShowHide.showHideConfirmPassword,
                typeInput: TextInputType.text)),
            textFieldInput("Nomor Telepon", "Nomor Telepon", _noTelpon, context,
                lenght: 13,
                typeInput: TextInputType.phone,
                formatter: [FilteringTextInputFormatter.digitsOnly]),
            spaceHeightMedium,
            Obx(() {
              if (controllerRegister.isLoading.value) {
                return loadingData("Proses pendaftaran akun....");
              } else {
                return buttonPrimary("Daftar", () {
                  String nama = _nama.text;
                  String email = _email.text;
                  String username = _username.text;
                  String password = _password.text;
                  String confirmPassword = _confirmpassword.text;
                  String phone = _noTelpon.text;

                  // String tokenPhone =
                  //     "dJgBJaowT9yQ2DmChnFvKV:APA91bElUt1CqxlfjWsmHsHLZHNRrWLDC3x2C3BgVgGHLdzyVgZmi-5ttGK8m6VY2QGP8IAbOHtZ8VNfDGnncignLXM48nAvIp16xGowmNcYDTVtGj4DxV-1XqdtSELq8GlI-hNTzbZ3";
                  bool checkField = controllerRegister.checkDataNullRegister(
                      nama, email, username, password, confirmPassword, phone);

                  if (!checkField) {
                    controllerRegister.register(
                        nama, email, username, password, phone);
                  }
                });
              }
            }),
            spaceHeightBig,
            Center(
              child: componenRichTextStyle("Sudah Punya Akun? ", "Masuk", () {
                if (!controllerRegister.isLoading.value) {
                  Get.offNamed(Routes.loginScreen);
                }
              }),
            ),
            spaceHeightBig,
          ],
        ),
      ),
    ));
  }
}
