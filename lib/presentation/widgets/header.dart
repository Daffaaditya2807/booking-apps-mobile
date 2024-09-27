import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/fonts_style/fonts_style.dart';
import 'list_button.dart';

AppBar headerWithIcon(String label) {
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
    backgroundColor: Colors.white,
  );
}

AppBar headerWithTabBar(
    String label, TabController controller, List<Tab> menuTabBar) {
  return AppBar(
    title: Text(
      label,
      style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth4),
    ),
    centerTitle: true,
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

TabBarView bodyTabBar(List<Widget> pages, TabController controller) {
  return TabBarView(
    controller: controller,
    children: pages,
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
