import 'package:apllication_book_now/presentation/pages/test_pages.dart';
import 'package:apllication_book_now/presentation/widgets/costume_navigation_bar/container_navbar.dart';
import 'package:apllication_book_now/presentation/widgets/costume_navigation_bar/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  PersistentTabController? _controller;
  List<ScrollController> _scrollControllers = [];

  List<CustomNavBarScreen> _buildScreens() {
    return [
      CustomNavBarScreen(
          screen: SingleChildScrollView(
              controller: _scrollControllers[0],
              child: const Center(child: Text("Page 0")))),
      CustomNavBarScreen(
        screen: SingleChildScrollView(
            controller: _scrollControllers[1],
            child: const Center(child: Text("Page 2"))),
        // scrollController: _scrollControllers[1],
      ),
      CustomNavBarScreen(
        screen: SingleChildScrollView(
            controller: _scrollControllers[2],
            child: const Center(child: Text("Page 3"))),
        // scrollController: _scrollControllers[2],
      ),
      CustomNavBarScreen(screen: TestPages()
          // scrollController: _scrollControllers[3],
          ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        scrollController: _scrollControllers[0],
        activeColorPrimary: const Color.fromRGBO(58, 92, 132, 1),
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.calendar),
        title: ("Layanan"),
        scrollController: _scrollControllers[1],
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        activeColorPrimary: const Color.fromRGBO(58, 92, 132, 1),
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.square_list_fill),
        title: ("Status"),
        scrollController: _scrollControllers[2],
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        activeColorPrimary: const Color.fromRGBO(58, 92, 132, 1),
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Akun"),
        scrollController: _scrollControllers[3],
        textStyle: GoogleFonts.montserrat(fontSize: 14),
        activeColorPrimary: const Color.fromRGBO(58, 92, 132, 1),
        inactiveColorPrimary: const Color.fromRGBO(142, 152, 168, 1),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _scrollControllers =
        List<ScrollController>.generate(4, (index) => ScrollController());
  }

  @override
  Widget build(BuildContext context) {
    return navbarPersistance(
        context,
        _controller!,
        _buildScreens(),
        _scrollControllers,
        CustomNavBarWidget(
            selectedIndex: _controller!.index,
            items: _navBarsItems(),
            onItemSelected: (index) {
              if (index == _controller!.index) {
                _scrollControllers[index].animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              }

              setState(() {
                _controller!.index = index;
              });
            }));
  }
}
