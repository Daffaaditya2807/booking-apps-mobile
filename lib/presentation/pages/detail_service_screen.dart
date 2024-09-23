import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_service.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';

class DetailServiceScreen extends StatelessWidget {
  const DetailServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithIcon("Detail Layanan"),
      body: _buildPageDetailService(context),
    );
  }

  SafeArea _buildPageDetailService(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          spaceHeightBig,
          detailService(context, "Layanan 1",
              "Jangan lewatkan kesempatan untuk merasakan layanan terbaik yang kami tawarkan! Segera booking sekarang dan dapatkan antrian lebih cepat untuk pengalaman yang memuaskan dan tak terlupakan. Waktu Anda berharga, jadi pastikan Anda mengambil langkah pertama hari ini."),
          Expanded(child: Container()),
          buttonPrimary("Booking", () {
            Get.toNamed(Routes.bookingScreen);
          }),
          spaceHeightBig,
          spaceHeightBig
        ],
      ),
    ));
  }
}
