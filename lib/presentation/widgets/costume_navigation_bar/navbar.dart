import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

PersistentTabView navbarPersistance(
    BuildContext context,
    PersistentTabController _controller,
    List<CustomNavBarScreen> pagesScreen,
    List<ScrollController> controllerList,
    Widget costumeNavbar) {
  return PersistentTabView.custom(
    context,
    controller: _controller,
    screens: pagesScreen,
    itemCount: pagesScreen.length,
    isVisible: true,
    hideOnScrollSettings: HideOnScrollSettings(
      hideNavBarOnScroll: true,
      scrollControllers: controllerList,
    ),
    backgroundColor: Colors.white,
    customWidget: costumeNavbar,
  );
}
