import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../resource/fonts_style/fonts_style.dart';
import '../state_management/controller_login.dart';
import '../state_management/controller_status_lewati.dart';
import 'list_button.dart';

AppBar headerWithIcon(String label, {Color? backgroundColor}) {
  backgroundColor ?? Colors.white;
  return AppBar(
    title: Text(
      label,
      style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth4),
    ),
    leading: Padding(
      padding: valuePaddingBig,
      child: backOutline(() {
        Get.back();
      }),
    ),
    centerTitle: true,
    elevation: 0,
    surfaceTintColor: Colors.white,
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Padding(
          padding: sidePaddingSmall,
          child: const Divider(
            thickness: 1.0,
          ),
        )),
    backgroundColor: backgroundColor,
  );
}

AppBar headerWithTabBar(
    String label, TabController controller, List<Tab> menuTabBar,
    {bool? useBadges = false, VoidCallback? onTapBadges}) {
  final statusLewatiController = Get.find<ControllerStatusLewati>();
  final userController = Get.find<ControllerLogin>();

  // Start listening to notifications when header is created
  statusLewatiController.listenToUnreadNotifications(
      userController.user.value!.idUsers.toString());
  return AppBar(
    title: Text(
      label,
      style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth4),
    ),
    centerTitle: true,
    actions: [
      useBadges == true
          ? Padding(
              padding: const EdgeInsets.only(right: 20),
              child: badges.Badge(
                badgeContent: Obx(() => Text(
                      "${statusLewatiController.unreadCount}",
                      style: semiBoldStyle.copyWith(
                        color: Colors.white,
                        fontSize: smallFont,
                      ),
                    )),
                onTap: () {
                  statusLewatiController.markNotificationsAsRead(
                      userController.user.value!.idUsers.toString());
                  onTapBadges?.call();
                },
                position: badges.BadgePosition.topEnd(top: -8, end: -5),
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.blue,
                  padding: EdgeInsets.all(5),
                  elevation: 0,
                ),
                child: const Icon(Icons.notifications),
              ),
            )
          : Container()
    ],
    elevation: 0,
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TabBar(
            controller: controller,
            labelStyle: semiBoldStyle.copyWith(
                color: blueSecondary, fontSize: regularFont),
            labelColor: blueSecondary,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4,
            unselectedLabelColor: greySecondary,
            indicatorColor: Colors.amber,
            tabs: menuTabBar)),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  );
}

Widget bodyTabBar(List<Widget> pages, TabController controller) {
  return TabBarView(
    controller: controller,
    // physics: const NeverScrollableScrollPhysics(),
    children: pages.map((widget) {
      return ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: Builder(
            builder: (context) {
              return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.minScrollExtent) {
                      return true;
                    }
                    return false;
                  },
                  child: widget);
            },
          ));
    }).toList(),
  );
}

AppBar header(String label) {
  return AppBar(
    title: Text(
      label,
      style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth4),
    ),
    centerTitle: true,
    elevation: 0,
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Padding(
          padding: sidePaddingSmall,
          child: const Divider(
            thickness: 1.0,
          ),
        )),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  );
}
