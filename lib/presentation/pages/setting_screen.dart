import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_font_size.dart';
import '../state_management/controller_login.dart';
import '../widgets/list_button.dart';

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
          componentTextMenu("Keluar", Icons.exit_to_app_outlined, () {
            Get.defaultDialog(
                title: "Keluar Akun",
                barrierDismissible: false,
                titleStyle: semiBoldStyle.copyWith(
                    color: bluePrimary, fontSize: fonth4),
                content: Padding(
                  padding: sidePaddingBig,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Yakin ingin keluar dari akun ini. Jika iya tekan tombol Ya",
                        textAlign: TextAlign.center,
                        style: regularStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      spaceHeightSmall,
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                              child: miniButtonOutline("Tidak", () {
                            Get.back();
                          })),
                          spaceWidthMedium,
                          Expanded(
                              child: miniButtonPrimary("Iya", () async {
                            controllerLogin.user.value = null;
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('user');
                            Get.offAllNamed(Routes.loginScreen);
                          })),
                        ],
                      )
                    ],
                  ),
                ));
          })
        ],
      ),
    ));
  }
}
