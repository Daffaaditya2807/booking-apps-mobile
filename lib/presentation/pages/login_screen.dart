import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:apllication_book_now/presentation/state_management/controller_show_hide.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../resource/sizes/list_margin.dart';
import '../../resource/sizes/list_padding.dart';
import '../widgets/list_button.dart';
import '../widgets/list_text.dart';
import '../widgets/list_textfield.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  bool isShow = true;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final ShowHidePassword controllerShowHide = Get.put(ShowHidePassword());
  final ControllerLogin controllerLogin =
      Get.put(ControllerLogin(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageLogin(context),
    );
  }

  SafeArea _buildPageLogin(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeightBig,
          componenTextHeaderDesc("Masuk", "Silakan masukkan data diri anda"),
          spaceHeightBig,
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
              controllerShowHide.isShow.value == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              controllerShowHide.showHidePassword,
              typeInput: TextInputType.text)),
          spaceHeightMedium,
          Obx(() {
            if (controllerLogin.isLoading.value) {
              return loadingData("Mencocokan data....");
            } else {
              return buttonPrimary("Masuk", () {
                String username = _username.text;
                String password = _password.text;
                bool checkField =
                    controllerLogin.checkDataNull(username, password);
                if (!checkField) {
                  controllerLogin.login(username, password).then((bool value) {
                    if (value) {
                      Get.toNamed(Routes.navbarMenu);
                    }
                  });
                }
              });
            }
          }),
          Expanded(child: Container()),
          Center(
            child: componenRichTextStyle("Belum Punya Akun? ", "Daftar", () {
              Get.toNamed(Routes.registerScreen);
            }),
          ),
          spaceHeightMedium
        ],
      ),
    ));
  }
}
