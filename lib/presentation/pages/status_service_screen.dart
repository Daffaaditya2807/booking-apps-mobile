import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_service.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/history_booking_model.dart';

// ignore: must_be_immutable
class StatusServiceScreen extends StatelessWidget {
  StatusServiceScreen({super.key});
  final status = Get.arguments as HistoryBookingModel;
  ControllerStatusScreen controllerStatusScreen =
      Get.put(ControllerStatusScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: headerWithIcon("Status Antrian",
          backgroundColor: Colors.grey.shade200),
      body: _buildPageServiceScreen(context),
    );
  }

  SafeArea _buildPageServiceScreen(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          Expanded(child: Container()),
          spaceHeightBig,
          InkWell(
            onTap: () {
              String idUser = status.idUser;
              if (status.status == 'dipesan') {
                controllerStatusScreen.assignAllHistoryPesan(idUser);
              } else if (status.status == 'diproses') {
                controllerStatusScreen.assignAllHistoryProses(idUser);
              } else if (status.status == 'selesai') {
                controllerStatusScreen.assignHistorySelesai(idUser);
              } else {
                controllerStatusScreen.assignHistoryDitolak(idUser);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: roundedMediumGeo),
              child: Padding(
                padding: valuePaddingMedium,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Muat Ulang",
                      style: semiBoldStyle.copyWith(color: bluePrimary),
                    ),
                    Icon(
                      Icons.refresh,
                      color: bluePrimary,
                    )
                  ],
                ),
              ),
            ),
          ),
          spaceHeightMedium,
          Obx(() {
            if (controllerStatusScreen.profileModel.value == null) {
              return Container();
            } else {
              return detailHistoryStatus(
                  context,
                  controllerStatusScreen.profileModel.value!.namaUsaha,
                  status.layanan.name,
                  status.status,
                  status.nomorBooking,
                  status.tanggal,
                  status.tanggal,
                  status.jamBooking,
                  status.noLoket,
                  status.idBooking,
                  status.catatan!);
            }
          }),
          Expanded(child: Container()),
          spaceHeightBig,
        ],
      ),
    ));
  }
}
