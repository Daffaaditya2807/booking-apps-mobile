import 'package:apllication_book_now/presentation/state_management/controller_reset_password.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_management/controller_show_hide.dart';
import '../widgets/list_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  // final user = Get.arguments as UserModel;
  final String email = Get.arguments['email'];
  final ShowHidePassword controllerShowHide = Get.put(ShowHidePassword());
  final ControllerResetPassword controllerResetPassword =
      Get.put(ControllerResetPassword());
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: sidePaddingBig,
          child: Column(
            children: [
              spaceHeightBig,
              componenTextHeaderDesc("Reset Password",
                  "Silakan ubah password dengan password baru dan harap diingat ingat"),
              spaceHeightBig,
              Obx(() => textFieldPassword(
                  "Password Baru",
                  "Password Baru",
                  controllerShowHide.isShow.value,
                  _password,
                  context,
                  controllerShowHide.isShow.value == true
                      ? Icons.visibility_off
                      : Icons.visibility,
                  controllerShowHide.showHidePassword,
                  typeInput: TextInputType.text)),
              Obx(() => textFieldPassword(
                  "Konfirmasi Password Baru",
                  "Konfirmasi Password Baru",
                  controllerShowHide.isShowConfirm.value,
                  _confirmPassword,
                  context,
                  controllerShowHide.isShowConfirm.value == true
                      ? Icons.visibility_off
                      : Icons.visibility,
                  controllerShowHide.showHideConfirmPassword,
                  typeInput: TextInputType.text)),
              spaceHeightBig,
              Obx(
                () => controllerResetPassword.isLoading.value
                    ? loadingData("mengubah password")
                    : buttonPrimary("Simpan", () {
                        controllerResetPassword.resetPassword(email,
                            _password.text, _confirmPassword.text, context);
                      }),
              ),
              spaceHeightBig
            ],
          ),
        ),
      ),
    );
  }
}
