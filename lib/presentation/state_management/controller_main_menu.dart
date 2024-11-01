import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../resource/list_color/colors.dart';
import '../pages/dashboard_screen.dart';
import '../pages/service_screen.dart';
import '../pages/setting_screen.dart';
import '../pages/status_screen.dart';

class ControllerMainMenu extends GetxController {
  PersistentTabController? controller;
  var index = 0.obs; // Using Rx for reactive state
  var scrollControllers = <ScrollController>[].obs;
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());

  List<CustomNavBarScreen> buildScreens() {
    return [
      CustomNavBarScreen(screen: DashboardScreen()),
      CustomNavBarScreen(
        screen: ServiceScreen(),
        // scrollController: _scrollControllers[1],
      ),
      const CustomNavBarScreen(
        screen: StatusScreen(),
        // scrollController: _scrollControllers[2],
      ),
      CustomNavBarScreen(screen: SettingScreen()
          // scrollController: _scrollControllers[3],
          ),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.house,
          // size: 30,
        ),
        title: ("Home"),
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        scrollController: scrollControllers[0],
        activeColorPrimary: bluePrimary,
        activeColorSecondary: blueTersier,
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.date_range_outlined),
        title: ("Layanan"),
        scrollController: scrollControllers[1],
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        activeColorPrimary: bluePrimary,
        activeColorSecondary: blueTersier,
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.list_alt_outlined),
        title: ("Status"),
        scrollController: scrollControllers[2],
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        activeColorPrimary: bluePrimary,
        activeColorSecondary: blueTersier,
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle_outlined),
        title: ("Akun"),
        scrollController: scrollControllers[3],
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        activeColorPrimary: bluePrimary,
        activeColorSecondary: blueTersier,
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
    ];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = PersistentTabController(initialIndex: 0);
    scrollControllers.value =
        List<ScrollController>.generate(4, (index) => ScrollController());
  }

  void updateIndex(int newIndex) {
    if (newIndex == index.value) {
      scrollControllers[newIndex].animateTo(0,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
    index.value = newIndex;
    controller?.jumpToTab(newIndex);
  }
}
