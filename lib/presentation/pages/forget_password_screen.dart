import 'package:flutter/material.dart';
import 'package:apllication_book_now/presentation/state_management/controller_forget_password.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/presentation/widgets/list_textfield.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';

import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController _controllerEmail = TextEditingController();
  final ControllerForgetPassword _controllerForgetPassword =
      Get.put(ControllerForgetPassword());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: sidePaddingBig,
          child: Column(
            children: [
              spaceHeightBig,
              componenTextHeaderDesc("Lupa Password",
                  "Silakan masukkan email yang sebelumnya telah didaftarkan pada aplikasi untuk memastikan apakah akun tersebut sudah dibuat"),
              spaceHeightBig,
              textFieldInput(
                "Email",
                "masukkan email",
                _controllerEmail,
                context,
                onSubmit: (value) {
                  _controllerForgetPassword
                      .checkUserAvailable(_controllerEmail.text);
                },
              ),
              Obx(() => _controllerForgetPassword.isLoading.value
                  ? loadingData("memerika user")
                  : buttonPrimary("Check User", () {
                      _controllerForgetPassword
                          .checkUserAvailable(_controllerEmail.text);
                    }))
            ],
          ),
        ),
      ),
    );
  }
}
