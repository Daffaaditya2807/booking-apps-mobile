import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/history_booking_model.dart';
import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/list_color/colors.dart';
import '../../resource/sizes/list_font_size.dart';
import '../widgets/list_button.dart';
import '../widgets/list_service.dart';

// ignore: must_be_immutable
class StatusServiceScreen extends StatelessWidget {
  StatusServiceScreen({super.key});
  final status = Get.arguments as HistoryBookingModel;
  ControllerStatusScreen controllerStatusScreen =
      Get.put(ControllerStatusScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithIcon("Status Antrian"),
      body: _buildPageServiceScreen(context),
    );
  }

  String hari(String tanggal) {
    DateTime parsedDate = DateTime.parse(tanggal);
    String convHari = DateFormat('EEEE').format(parsedDate);
    return convHari;
  }

  String tanggal(String tanggal) {
    DateTime parsedDate = DateTime.parse(tanggal);
    String convTanggal = DateFormat('dd MMMM yyyy').format(parsedDate);
    return convTanggal;
  }

  SafeArea _buildPageServiceScreen(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          spaceHeightBig,
          detailStatusService(
            context,
            status.layanan.name,
            status.status,
            status.jamBooking,
            hari(status.tanggal),
            tanggal(status.tanggal),
            status.noLoket,
            status.catatan.toString(),
            '$apiImage${status.layanan.image}',
            function: () {
              if (status.status == 'diproses') {
                Get.defaultDialog(
                    title: "Selesaikan Booking?",
                    barrierDismissible: false,
                    titleStyle: semiBoldStyle.copyWith(
                        color: bluePrimary, fontSize: fonth4),
                    content: Padding(
                      padding: sidePaddingBig,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tekan tombol selesai untuk menyelesaikan pesanan",
                            textAlign: TextAlign.center,
                            style: regularStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          spaceHeightSmall,
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                  child: miniButtonOutline("Batal", () {
                                Get.back();
                              })),
                              spaceWidthMedium,
                              Expanded(
                                  child: miniButtonPrimary("Selesai", () {
                                print(status.idBooking);
                                controllerStatusScreen
                                    .updateStatusProsesUser(status.idBooking);
                              })),
                            ],
                          )
                        ],
                      ),
                    ));
              }
            },
          )
        ],
      ),
    ));
  }
}
