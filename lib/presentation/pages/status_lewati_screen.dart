import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_management/controller_status_lewati.dart';

class StatusLewatiScreen extends StatelessWidget {
  final controllerLewati = Get.put(ControllerStatusLewati());
  StatusLewatiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("Pesanan Dilewati"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: sidePaddingBig,
          child: Obx(() => ListView.builder(
                itemCount: controllerLewati.lewatiList.length,
                itemBuilder: (context, index) {
                  final notification = controllerLewati.lewatiList[index];
                  return buildNotificationCard(notification);
                },
              )),
        ),
      ),
    );
  }

  Widget buildNotificationCard(Map<String, dynamic> notification) {
    return Column(
      children: [
        spaceHeightBig,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade300.withOpacity(0.2),
              borderRadius: roundedMediumGeo,
              border: Border.all(color: greyTersier)),
          child: Padding(
            padding: valuePaddingBig,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceHeightSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nomor Booking ${notification['nomor_booking']}",
                      style: semiBoldStyle.copyWith(color: blueTersier),
                    ),
                    Text(
                      "#${notification['id_booking']}",
                      style: semiBoldStyle.copyWith(color: blueTersier),
                    ),
                  ],
                ),
                if (notification['status_lewati'] != null)
                  Text(
                    "Pesanan anda telah dilewati sebanyak ${notification['status_lewati']}x",
                    style: regularStyle.copyWith(
                        color: Colors.black, fontSize: regularFont),
                  ),
                spaceHeightSmall,
                DottedLine(
                  dashLength: 5,
                  lineThickness: 1.0,
                  dashGapLength: 3,
                  dashRadius: 3,
                  dashColor: greyPrimary,
                ),
                spaceHeightSmall,
                // Add other notification details here
                buildDetailRow("Layanan", notification['nama_layanan'] ?? '-'),
                buildDetailRow("Tanggal", notification['tanggal'] ?? '-'),
                buildDetailRow(
                    "Jam Booking", notification['jam_booking'] ?? '-'),
                buildDetailRow("No Pelayanan",
                    notification['no_pelayanan']?.toString() ?? '-'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              regularStyle.copyWith(color: Colors.black, fontSize: regularFont),
        ),
        Text(
          value,
          style:
              regularStyle.copyWith(color: Colors.black, fontSize: regularFont),
        ),
      ],
    );
  }
}
