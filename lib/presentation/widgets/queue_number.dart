import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/material.dart';

Widget queueNumberNow(String queuNumberNow, String timeBookedNow) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: greySecondary),
        borderRadius: roundedMediumGeo),
    child: Padding(
      padding: valuePaddingBig,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nomor Antrian Sekarang",
            style:
                regularStyle.copyWith(color: greyPrimary, fontSize: smallFont),
          ),
          spaceHeightSmall,
          Text(
            queuNumberNow,
            style: boldStyle.copyWith(fontSize: 35, color: Colors.black),
          ),
          spaceHeightSmall,
          Text(
            "Jam: $timeBookedNow",
            style: boldStyle.copyWith(fontSize: smallFont, color: greyPrimary),
          ),
        ],
      ),
    ),
  );
}

Widget queueNumberUser(String queuNumberUser, String timeBookedUser) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: greySecondary),
        borderRadius: roundedMediumGeo),
    child: Padding(
      padding: valuePaddingBig,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Nomor Antrian Anda",
            style:
                regularStyle.copyWith(color: greyPrimary, fontSize: smallFont),
          ),
          spaceHeightSmall,
          Text(
            queuNumberUser,
            style: boldStyle.copyWith(fontSize: 35, color: Colors.black),
          ),
          spaceHeightSmall,
          Text(
            "Layanan : Layanan 1 || Jam: $timeBookedUser",
            style: boldStyle.copyWith(fontSize: smallFont, color: greyPrimary),
          ),
        ],
      ),
    ),
  );
}
