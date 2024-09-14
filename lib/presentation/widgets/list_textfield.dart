import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';

Widget textFieldInput(String label, String hintext,
    TextEditingController controller, BuildContext context,
    {TextInputType? typeInput, List<TextInputFormatter>? formatter}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: mediumStyle.copyWith(color: Colors.black, fontSize: fonth6),
      ),
      spaceHeightMedium,
      Theme(
        data: Theme.of(context).copyWith(
            textSelectionTheme:
                TextSelectionThemeData(selectionColor: bluePrimary)),
        child: TextField(
          style: regularStyle.copyWith(color: Colors.black),
          controller: controller,
          cursorColor: blueSecondary,
          cursorWidth: 1.5,
          inputFormatters: formatter,
          keyboardType: typeInput,
          decoration: InputDecoration(
              hintText: hintext,
              hintStyle: regularStyle.copyWith(color: greySecondary),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: greySecondary),
                borderRadius: borderRoundedMedium,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greySecondary),
                borderRadius: borderRoundedMedium,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueSecondary, width: 1.5),
                borderRadius: borderRoundedMedium,
              )),
        ),
      ),
      spaceHeightBig
    ],
  );
}

Widget textFieldPassword(
    String label,
    String hintext,
    bool isShow,
    TextEditingController controller,
    BuildContext context,
    IconData showHide,
    VoidCallback funcion,
    {TextInputType? typeInput,
    List<TextInputFormatter>? formatter}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: mediumStyle.copyWith(color: Colors.black, fontSize: fonth6),
      ),
      spaceHeightMedium,
      Theme(
        data: Theme.of(context).copyWith(
            textSelectionTheme:
                TextSelectionThemeData(selectionColor: bluePrimary)),
        child: TextField(
          style: regularStyle.copyWith(color: Colors.black),
          controller: controller,
          cursorColor: blueSecondary,
          cursorWidth: 1.5,
          obscureText: isShow,
          inputFormatters: formatter,
          keyboardType: typeInput,
          decoration: InputDecoration(
              hintText: hintext,
              hintStyle: regularStyle.copyWith(color: greySecondary),
              suffixIcon: IconButton(onPressed: funcion, icon: Icon(showHide)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: greySecondary),
                borderRadius: borderRoundedMedium,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greySecondary),
                borderRadius: borderRoundedMedium,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueSecondary, width: 1.5),
                borderRadius: borderRoundedMedium,
              )),
        ),
      ),
      spaceHeightBig
    ],
  );
}
