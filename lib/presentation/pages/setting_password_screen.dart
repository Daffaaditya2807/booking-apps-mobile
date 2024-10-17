import 'package:apllication_book_now/presentation/state_management/controller_password.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_management/controller_login.dart';
import '../state_management/controller_show_hide.dart';
import '../widgets/list_textfield.dart';

class SettingPasswordScreen extends StatelessWidget {
  SettingPasswordScreen({super.key});
  final TextEditingController _password = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final ShowHidePassword controllerShowHide = Get.put(ShowHidePassword());
  final ControllerPassword controllerPassword = Get.put(ControllerPassword());
  final controllerLogin = Get.find<ControllerLogin>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithIcon("Ubah Password", backgroundColor: Colors.white),
      body: _buildPageChangePassword(context),
    );
  }

  SafeArea _buildPageChangePassword(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          spaceHeightBig,
          Obx(() => textFieldPassword(
              "Password Lama",
              "Password Lama",
              controllerShowHide.isPasswordOld.value,
              _oldPassword,
              context,
              controllerShowHide.isPasswordOld.value == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              controllerShowHide.showHideOldPassword,
              typeInput: TextInputType.text)),
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
          Expanded(child: Container()),
          Obx(() {
            if (controllerPassword.isLoading.value) {
              return loadingData("Mengubah Password...");
            } else {
              return buttonPrimary("Simpan", () {
                String idUser = controllerLogin.user.value!.idUsers.toString();
                String oldPassword = _oldPassword.text;
                String newPassword = _password.text;
                String confirmPassword = _confirmPassword.text;
                // print(
                //     "password : $oldPassword dan old password : $confirmPassword dan $newPassword dan Id User : $idUser");

                bool checkField = controllerPassword.checkDataPassword(
                    oldPassword, newPassword, confirmPassword);

                if (!checkField) {
                  controllerPassword
                      .updatePassword(
                          idUser, oldPassword, confirmPassword, newPassword)
                      .then((value) {
                    if (value) {
                      _oldPassword.text = '';
                      _password.text = '';
                      _confirmPassword.text = '';
                    }
                  });
                }
              });
            }
          }),
          spaceHeightBig
        ],
      ),
    ));
  }
}
