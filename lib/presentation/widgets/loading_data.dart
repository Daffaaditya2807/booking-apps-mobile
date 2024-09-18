import 'package:flutter/material.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_margin.dart';

Widget loadingData(String message) {
  return Center(
      child: Column(
    children: [
      CircularProgressIndicator(
        strokeWidth: 2.5,
        color: bluePrimary,
      ),
      spaceHeightSmall,
      Text(
        message,
        style: regularStyle.copyWith(color: greyPrimary),
      )
    ],
  ));
}
