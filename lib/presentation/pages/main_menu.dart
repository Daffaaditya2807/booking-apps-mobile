import 'package:apllication_book_now/presentation/state_management/controller_main_menu.dart';
import 'package:apllication_book_now/presentation/widgets/costume_navigation_bar/container_navbar.dart';
import 'package:apllication_book_now/presentation/widgets/costume_navigation_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/routes.dart';
import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_font_size.dart';
import '../../resource/sizes/list_margin.dart';
import '../../resource/sizes/list_padding.dart';
import '../state_management/controller_login.dart';
import '../widgets/list_button.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final ControllerMainMenu _controllerMainMenu = Get.put(ControllerMainMenu());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          Get.defaultDialog(
              title: "Keluar Akun",
              barrierDismissible: false,
              titleStyle:
                  semiBoldStyle.copyWith(color: bluePrimary, fontSize: fonth4),
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
                          Get.delete<ControllerLogin>();
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
          return false;
        },
        child: navbarPersistance(
          context,
          _controllerMainMenu.controller!,
          _controllerMainMenu.buildScreens(),
          _controllerMainMenu.scrollControllers,
          CustomNavBarWidget(
            selectedIndex: _controllerMainMenu.index.value,
            items: _controllerMainMenu.navBarsItems(),
            onItemSelected: (index) => _controllerMainMenu.updateIndex(index),
          ),
        ),
      );
    });
  }
}
