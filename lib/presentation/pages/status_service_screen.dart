import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/list_service.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/history_booking_model.dart';
import '../../resource/sizes/list_font_size.dart';
import '../widgets/list_button.dart';

// ignore: must_be_immutable
class StatusServiceScreen extends StatelessWidget {
  StatusServiceScreen({super.key});
  final Rx<HistoryBookingModel> status =
      (Get.arguments as HistoryBookingModel).obs;
  ControllerStatusScreen controllerStatusScreen =
      Get.put(ControllerStatusScreen());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controllerStatusScreen.statusPesanan.value = '';
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: headerWithIcon("Status Antrian",
            backgroundColor: Colors.grey.shade200),
        body: _buildPageServiceScreen(context),
      ),
    );
  }

  AppBar headerWithIcon(String label, {Color? backgroundColor}) {
    backgroundColor ?? Colors.white;
    return AppBar(
      title: Text(
        label,
        style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth4),
      ),
      leading: Padding(
        padding: valuePaddingBig,
        child: backOutline(() {
          controllerStatusScreen.statusPesanan.value = '';
          Get.back();
        }),
      ),
      centerTitle: true,
      elevation: 0,
      surfaceTintColor: Colors.white,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Padding(
            padding: sidePaddingSmall,
            child: const Divider(
              thickness: 1.0,
            ),
          )),
      backgroundColor: backgroundColor,
    );
  }

  SafeArea _buildPageServiceScreen(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          Expanded(child: Container()),
          spaceHeightMedium,
          Obx(() {
            if (controllerStatusScreen.profileModel.value == null) {
              return Container();
            } else {
              return detailHistoryStatus(
                  context,
                  controllerStatusScreen.profileModel.value!.namaUsaha,
                  status.value.layanan.name,
                  controllerStatusScreen.statusPesanan.value == ''
                      ? status.value.status
                      : controllerStatusScreen.statusPesanan.value,
                  status.value.nomorBooking,
                  status.value.tanggal,
                  status.value.tanggal,
                  status.value.jamBooking,
                  status.value.noLoket,
                  status.value.idBooking,
                  status.value.catatan!,
                  status.value.createdAt.toString(),
                  status.value.statusLewati,
                  controllerStatusScreen.profileModel.value!.logo);
            }
          }),
          Expanded(child: Container()),
          spaceHeightMedium
        ],
      ),
    ));
  }
}
