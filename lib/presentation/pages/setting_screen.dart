import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_management/controller_login.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final controllerLogin = Get.find<ControllerLogin>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header("Akun"),
      body: _buildPageSetting(),
    );
  }

  SafeArea _buildPageSetting() {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeightBig,
          Obx(() => componentTextGreeting(
              "${controllerLogin.user.value?.namaPembeli ?? 'Guest'}!")),
          spaceHeightMedium,
          componentTextMenu("Ubah Profile", Icons.account_circle_outlined, () {
            Get.toNamed(Routes.profileSettingScreen);
          }),
          componentTextMenu("Ubah Password", Icons.vpn_key_outlined, () {
            Get.toNamed(Routes.passwordSettingScreen);
          }),
          componentTextMenu("Keluar", Icons.exit_to_app_outlined, () {})
        ],
      ),
    ));
  }
}
