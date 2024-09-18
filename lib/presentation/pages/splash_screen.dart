import 'package:apllication_book_now/presentation/state_management/controller_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageSplashScreen(),
    );
  }

  Center _buildPageSplashScreen() {
    Get.put(ControllerSplashScreen());
    return Center(
      child: Image.asset(
        "assets/image/splash_screen/booknow.png",
        width: 200,
        height: 200,
      ),
    );
  }
}
