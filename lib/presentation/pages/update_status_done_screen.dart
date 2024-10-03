import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../resource/sizes/list_margin.dart';
import '../../resource/sizes/list_padding.dart';
import '../widgets/information.dart';
import '../widgets/list_button.dart';

class ScreenUpdateStatusDone extends StatelessWidget {
  const ScreenUpdateStatusDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageBookingDone(),
    );
  }

  SafeArea _buildPageBookingDone() {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          informationTextAsset(
              "assets/image/splash_screen/booking.png",
              "Booking Selesai!",
              "Terimah kasih telah menggunakan jasa booking pada aplikasi kami. Semoga hasilnya memuaskan ya.. "),
          Expanded(child: Container()),
          buttonPrimary("Selesai", () {
            Get.offAllNamed(Routes.navbarMenu);
          }),
          spaceHeightBig
        ],
      ),
    ));
  }
}
