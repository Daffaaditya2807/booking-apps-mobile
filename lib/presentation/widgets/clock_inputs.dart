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
      padding: sideVerticalPaddingBig,
      child: Text(
        time,
        style: mediumStyle.copyWith(fontSize: fonth2, color: bluePrimary),
      ),
    ),
  );
}

Widget selectedTime(String time) {
  return Container(
    decoration: BoxDecoration(
        color: bluePrimary, borderRadius: BorderRadius.all(roundedMedium)),
    child: Padding(
      padding: sideVerticalPaddingBig,
      child: Text(
        time,
        style: mediumStyle.copyWith(fontSize: fonth2),
      ),
    ),
  );
}

Widget nonAvailableTime(String time) {
  return Container(
    decoration: BoxDecoration(
        color: blueSecondary, borderRadius: BorderRadius.all(roundedMedium)),
    child: Padding(
      padding: sideVerticalPaddingBig,
      child: Text(
        time,
        style: mediumStyle.copyWith(fontSize: fonth2),
      ),
    ),
  );
}
