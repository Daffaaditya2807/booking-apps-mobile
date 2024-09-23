import 'package:apllication_book_now/presentation/widgets/information.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';

class BookingDoneScreen extends StatelessWidget {
  const BookingDoneScreen({super.key});

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
              "Booking Berhasil!",
              "Selamat! Booking antrian untuk layanan 1  berhasil. Tunggu pemberitahuan lanjut untuk menikmati layanan terbaik  kami. "),
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
