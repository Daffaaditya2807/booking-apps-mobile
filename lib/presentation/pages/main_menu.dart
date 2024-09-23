import 'package:apllication_book_now/presentation/state_management/controller_main_menu.dart';
import 'package:apllication_book_now/presentation/widgets/costume_navigation_bar/container_navbar.dart';
import 'package:apllication_book_now/presentation/widgets/costume_navigation_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final ControllerMainMenu _controllerMainMenu = Get.put(ControllerMainMenu());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return navbarPersistance(
        context,
        _controllerMainMenu.controller!,
        _controllerMainMenu.buildScreens(),
        _controllerMainMenu.scrollControllers,
        CustomNavBarWidget(
          selectedIndex: _controllerMainMenu.index.value,
          items: _controllerMainMenu.navBarsItems(),
          onItemSelected: (index) => _controllerMainMenu.updateIndex(index),
        ),
      );
    });
  }
}
