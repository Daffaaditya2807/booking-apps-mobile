import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../resource/sizes/list_margin.dart';
import '../../resource/sizes/list_padding.dart';
import '../widgets/information.dart';
import '../widgets/list_button.dart';

class IntroductionLastScreen extends StatelessWidget {
  const IntroductionLastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageIntroductionLast(),
    );
  }

  Padding _buildPageIntroductionLast() {
    return Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          Expanded(child: Container()),
          informationText(
              "assets/image/splash_screen/splash_screen_2.svg",
              "Anda malas menunggu?",
              "Ambil antrian sekarang juga dan nikmati kenyamanan tanpa menunggu!"),
          Expanded(child: Container()),
          buttonPrimary("Daftar Sekarang", () {
            Get.offNamed(Routes.loginScreen);
          }),
          spaceHeightBig
        ],
      ),
    );
  }
}
