import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_margin.dart';

Widget componentTextMenu(
    String label, IconData iconsLabel, VoidCallback function) {
  return Padding(
    padding: verticalPaddingSmall,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              iconsLabel,
              size: 30,
              color: blueTersier,
            ),
            spaceWidthMedium,
            Text(
              label,
              style: boldStyle.copyWith(fontSize: fonth5, color: blueTersier),
            )
          ],
        ),
        IconButton(
            onPressed: function,
            icon: Icon(
              CupertinoIcons.chevron_forward,
              size: 30,
              color: blueTersier,
            ))
      ],
    ),
  );
}

Widget componenTextHeaderDesc(String header, String desc, {Color? warna}) {
  final Color effectiveWarna = warna ?? bluePrimary;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        header,
        style: semiBoldStyle.copyWith(fontSize: fonth3, color: effectiveWarna),
      ),
      spaceHeightSmall,
      Text(
        desc,
        style: mediumStyle.copyWith(fontSize: fonth6, color: greyPrimary),
      ),
    ],
  );
}

Widget componenRichTextStyle(
    String firstText, String lastText, VoidCallback function) {
  return RichText(
    text: TextSpan(
        text: firstText,
        style: mediumStyle.copyWith(fontSize: fonth6, color: greyPrimary),
        children: <TextSpan>[
          TextSpan(
              text: lastText,
              style:
                  semiBoldStyle.copyWith(fontSize: fonth6, color: bluePrimary),
              recognizer: TapGestureRecognizer()..onTap = function)
        ]),
  );
}

Widget componentTextGreeting(String personName) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Halo!",
        style: semiBoldStyle.copyWith(fontSize: fonth3, color: blueTersier),
      ),
      spaceHeightMedium,
      Text(
        personName,
        style: mediumStyle.copyWith(fontSize: fonth6, color: greyPrimary),
      ),
    ],
  );
}

Widget componentTextDetailBooking(
    String day, String date, String time, String service) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Detail antrian anda",
        style: boldStyle.copyWith(fontSize: fonth4, color: Colors.black),
      ),
      spaceHeightMedium,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hari",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            day,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tanggal",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            date,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Waktu",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            time,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Layanan",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            service,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
    ],
  );
}

Widget componentTextDetailStatusBooking(
    String day, String date, String time, String service, String status,
    {String? reasonStatus}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Status antrian anda",
            style: boldStyle.copyWith(fontSize: fonth4, color: Colors.black),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    bluePrimary,
                    blueSecondary
                  ], // Sesuaikan warna gradient di sini
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: roundedMediumGeo),
            child: Padding(
              padding: sideVerticalPaddingMedium,
              child: Text(
                status,
                style: mediumStyle.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      spaceHeightMedium,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hari",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            day,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tanggal",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            date,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Waktu",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            time,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Layanan",
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
          Text(
            service,
            style: regularStyle.copyWith(fontSize: fonth5, color: Colors.black),
          ),
        ],
      ),
      spaceHeightSmall,
      status == 'Ditolak'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Alasan ditolak",
                  style: regularStyle.copyWith(
                      fontSize: fonth5, color: Colors.black),
                ),
                Text(
                  reasonStatus ?? "",
                  style: regularStyle.copyWith(
                      fontSize: fonth5, color: Colors.black),
                ),
              ],
            )
          : Container(),
      spaceHeightSmall,
    ],
  );
}
