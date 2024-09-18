import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snackBarSucces(String title, String messageSucces) {
  return Get.snackbar(title, messageSucces,
      icon: Icon(
        Icons.done,
        color: bluePrimary,
      ),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.white,
      borderWidth: 1.0,
      borderColor: greySecondary,
      messageText: Text(
        messageSucces,
        style: regularStyle.copyWith(color: greyPrimary, fontSize: regularFont),
      ),
      titleText: Text(
        title,
        style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth6),
      ));
}

SnackbarController snackBarError(String title, String messageError) {
  return Get.snackbar(title, messageError,
      icon: Icon(
        Icons.cancel_outlined,
        color: Colors.redAccent,
      ),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.white,
      borderWidth: 1.0,
      borderColor: Colors.redAccent,
      messageText: Text(
        messageError,
        style: regularStyle.copyWith(color: greyPrimary, fontSize: regularFont),
      ),
      titleText: Text(
        title,
        style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth6),
      ));
}
