import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/presentation/widgets/information.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionFirst extends StatelessWidget {
  const IntroductionFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageIntroductionFirst(),
    );
  }

  Padding _buildPageIntroductionFirst() {
    return Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          Expanded(child: Container()),
          informationText(
              "assets/image/splash_screen/splash_screen_1.svg",
              "Kemudahan menanti anda",
              "Pesan layanan dengan cepat dan tunggu pemberitahuan lebih lanjut untuk menikmati layanan terbaik kami!"),
          Expanded(child: Container()),
          buttonPrimary("Lanjutkan", () {
            Get.offNamed(Routes.introductionLast);
          }),
          spaceHeightBig
        ],
      ),
    );
  }
}
