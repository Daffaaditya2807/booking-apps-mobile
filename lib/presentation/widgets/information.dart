import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget informationText(String assetName, String header, String description) {
  return Column(
    children: [
      SvgPicture.asset(assetName),
      spaceHeightMedium,
      Text(
        header,
        style: boldStyle.copyWith(color: blueSecondary, fontSize: fonth2),
      ),
      spaceHeightMedium,
      Text(
        description,
        textAlign: TextAlign.center,
        style: mediumStyle.copyWith(color: greyPrimary, fontSize: fonth6),
      )
    ],
  );
}

Widget informationTextAsset(
    String assetName, String header, String description) {
  return Column(
    children: [
      Image.asset(assetName),
      spaceHeightMedium,
      Text(
        header,
        style: boldStyle.copyWith(color: blueSecondary, fontSize: fonth2),
      ),
      spaceHeightMedium,
      Text(
        description,
        textAlign: TextAlign.center,
        style: mediumStyle.copyWith(color: greyPrimary, fontSize: fonth6),
      )
    ],
  );
}
