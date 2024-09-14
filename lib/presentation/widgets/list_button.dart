import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:flutter/material.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_padding.dart';
import '../../resource/sizes/list_rounded.dart';

Widget miniButtonPrimary(String text, VoidCallback funcion) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: bluePrimary,
          padding: valuePaddingBig,
          shape: RoundedRectangleBorder(borderRadius: roundedMediumGeo)),
      onPressed: funcion,
      child: Text(
        text,
        style: mediumStyle.copyWith(fontSize: regularFont),
      ));
}

Widget buttonPrimary(String text, VoidCallback funcion) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: bluePrimary,
          minimumSize: const Size.fromHeight(51),
          shape: RoundedRectangleBorder(borderRadius: roundedMediumGeo)),
      onPressed: funcion,
      child: Text(
        text,
        style: semiBoldStyle.copyWith(fontSize: fonth5),
      ));
}

Widget miniButtonSecondary(String text, VoidCallback funcion) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: blueSecondary,
          padding: valuePaddingBig,
          shape: RoundedRectangleBorder(borderRadius: roundedMediumGeo)),
      onPressed: funcion,
      child: Text(
        text,
        style: mediumStyle.copyWith(fontSize: regularFont),
      ));
}

Widget buttonSecondary(String text, VoidCallback funcion) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: blueSecondary,
          minimumSize: const Size.fromHeight(51),
          shape: RoundedRectangleBorder(borderRadius: roundedMediumGeo)),
      onPressed: funcion,
      child: Text(
        text,
        style: semiBoldStyle.copyWith(fontSize: fonth5),
      ));
}

Widget miniButtonOutline(String text, VoidCallback funcion) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: valuePaddingBig,
          shape: RoundedRectangleBorder(
              borderRadius: roundedMediumGeo,
              side: BorderSide(color: bluePrimary, width: 1.5))),
      onPressed: funcion,
      child: Text(
        text,
        style: mediumStyle.copyWith(fontSize: regularFont, color: bluePrimary),
      ));
}

Widget buttonOutline(String text, VoidCallback funcion) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size.fromHeight(51),
          shape: RoundedRectangleBorder(
              borderRadius: roundedMediumGeo,
              side: BorderSide(color: bluePrimary, width: 1.5))),
      onPressed: funcion,
      child: Text(
        text,
        style: semiBoldStyle.copyWith(fontSize: fonth5, color: bluePrimary),
      ));
}

Widget backOutline(VoidCallback function) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: roundedMediumGeo, border: Border.all(color: greyPrimary)),
    child: InkWell(
      onTap: function,
      child: Icon(
        Icons.chevron_left,
        size: 30,
        color: greyPrimary,
      ),
    ),
  );
}
