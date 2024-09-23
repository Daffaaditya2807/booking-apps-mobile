import 'package:flutter/material.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_font_size.dart';
import '../../resource/sizes/list_padding.dart';
import '../../resource/sizes/list_rounded.dart';

Widget availableTime(String time) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: bluePrimary, width: 1.5),
        borderRadius: BorderRadius.all(roundedMedium)),
    child: Padding(
      padding: sideVerticalPaddingMedium,
      child: Text(
        time,
        style: mediumStyle.copyWith(fontSize: fonth3, color: bluePrimary),
      ),
    ),
  );
}

Widget selectedTime(String time) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bluePrimary,
            blueSecondary
          ], // Sesuaikan warna gradient di sini
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(width: 1.5, color: bluePrimary),
        borderRadius: BorderRadius.all(roundedMedium)),
    child: Padding(
      padding: sideVerticalPaddingMedium,
      child: Text(
        time,
        style: mediumStyle.copyWith(fontSize: fonth3),
      ),
    ),
  );
}

Widget nonAvailableTime(String time) {
  return Container(
    decoration: BoxDecoration(
        color: greyTersier,
        borderRadius: BorderRadius.all(roundedMedium),
        border: Border.all(width: 1.5, color: greyTersier)),
    child: Padding(
      padding: sideVerticalPaddingMedium,
      child: Text(
        time,
        style: mediumStyle.copyWith(fontSize: fonth3),
      ),
    ),
  );
}
