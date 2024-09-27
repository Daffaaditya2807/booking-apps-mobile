import 'package:apllication_book_now/presentation/state_management/controller_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageSplashScreen(context),
    );
  }

  Center _buildPageSplashScreen(BuildContext context) {
    double heightAppBar = MediaQuery.of(context).viewPadding.top;
    double heightScreen = MediaQuery.sizeOf(context).height;
    double heightContainer =
        (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
    Get.put(ControllerSplashScreen());
    return Center(
      child: Image.asset(
        "assets/image/logo/logoapps.jpg",
        height: heightContainer,
      ),
    );
  }
}
