import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_margin.dart';

Widget loadingData(String message) {
  return Center(
      child: Column(
    children: [
      Lottie.asset('assets/image/animload.json',
          fit: BoxFit.cover, width: 200, height: 60),
      spaceHeightSmall,
      Text(
        message,
        style: regularStyle.copyWith(color: greyPrimary),
      )
    ],
  ));
}
