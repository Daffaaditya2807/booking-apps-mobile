import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget noInternetConnection() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/image/no_internet.json",
              width: 200, height: 200),
          Text(
            "Tidak ada koneksi internet",
            style: semiBoldStyle.copyWith(color: bluePrimary, fontSize: fonth2),
          ),
          Text(
            "Mohon periksa! koneksi internet pada perangkat anda pastikan nyalakan Data seluler atau WI-FI untuk mengakses aplikasi",
            textAlign: TextAlign.center,
            style: regularStyle.copyWith(
                color: Colors.black, fontSize: regularFont),
          )
        ],
      ),
    ),
  );
}
