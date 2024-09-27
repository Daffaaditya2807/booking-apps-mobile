import 'package:flutter/material.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_padding.dart';
import '../../resource/sizes/list_rounded.dart';

Widget selectedLocket(String selectedLocket) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    height: 30,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bluePrimary,
            blueSecondary
          ], // Sesuaikan warna gradient di sini
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: bluePrimary),
        borderRadius: borderRoundedMedium),
    child: Center(
        child: Padding(
      padding: sidePaddingMedium,
      child: Text(
        "Loket $selectedLocket",
        style: regularStyle,
      ),
    )),
  );
}

Widget availableLoket(String loketAvailable) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    height: 30,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: bluePrimary),
        borderRadius: borderRoundedMedium),
    child: Center(
        child: Padding(
      padding: sidePaddingMedium,
      child: Text(
        "Loket $loketAvailable",
        style: regularStyle.copyWith(color: bluePrimary),
      ),
    )),
  );
}
