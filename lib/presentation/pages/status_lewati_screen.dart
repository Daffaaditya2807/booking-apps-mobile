import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_service.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../state_management/controller_status_lewati.dart';
import '../widgets/list_button.dart';
import '../widgets/loading_data.dart';

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
          child: Obx(() => controllerLewati.lewatiList.isEmpty
              ? emptyListService(
                  header: "Pesanan Dilewati Kosong",
                  deskripsi:
                      "Tidak ada pesanan anda buat dilewati. Semua pesanan berhasil diproses dengan baik")
              : ListView.builder(
                  itemCount: controllerLewati.lewatiList.length,
                  itemBuilder: (context, index) {
                    final notification = controllerLewati.lewatiList[index];
                    return buildNotificationCard(notification, () {
                      Get.defaultDialog(
                          title: "Hapus Data",
                          barrierDismissible: false,
                          titleStyle: semiBoldStyle.copyWith(
                              color: bluePrimary, fontSize: fonth4),
                          content: Padding(
                            padding: sidePaddingBig,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Yakin ingin hapus data?",
                                  textAlign: TextAlign.center,
                                  style: regularStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                spaceHeightSmall,
                                const Divider(),
                                Obx(() => controllerLewati.isLoading.value
                                    ? loadingData("hapus data")
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: miniButtonOutline("Tidak",
                                                  () {
                                            Get.back();
                                          })),
                                          spaceWidthMedium,
                                          Expanded(
                                              child:
                                                  miniButtonPrimary("Iya", () {
                                            controllerLewati.deleteData(
                                                notification['id_booking']);
                                            Get.back();
                                          })),
                                        ],
                                      ))
                              ],
                            ),
                          ));
                    });
                  },
                )),
        ),
      ),
    );
  }

  String hari(String tanggal) {
    DateTime parsedDate = DateTime.parse(tanggal);
    String convHari = DateFormat('EEEE', 'id').format(parsedDate);
    return convHari;
  }

  Widget buildNotificationCard(
      Map<String, dynamic> notification, VoidCallback delete) {
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
                spaceHeightSmall,
                if (notification['catatan'] != null)
                  Text(
                    notification['catatan'],
                    textAlign: TextAlign.justify,
                    style: regularStyle.copyWith(
                        color: Colors.black, fontSize: regularFont),
                  ),
                spaceHeightMedium,
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
                buildDetailRow("Hari", hari(notification['tanggal'])),
                buildDetailRow("Tanggal", notification['tanggal'] ?? '-'),

                buildDetailRow("Jam Booking",
                    notification['jam_booking'].toString().substring(0, 5)),
                spaceHeightMedium,
                InkWell(
                  onTap: delete,
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: greyTersier),
                          borderRadius: borderRoundedMedium),
                      child: Padding(
                        padding: valuePaddingMedium,
                        child: Icon(
                          Icons.delete,
                          color: Colors.grey.shade700,
                        ),
                      )),
                )
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
          style: semiBoldStyle.copyWith(
              color: Colors.black, fontSize: regularFont),
        ),
      ],
    );
  }
}
