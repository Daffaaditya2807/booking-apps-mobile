import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/history_booking_model.dart';
import '../widgets/list_service.dart';

class StatusServiceScreen extends StatelessWidget {
  StatusServiceScreen({super.key});
  final status = Get.arguments as HistoryBookingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            status.layanan.image,
          )
        ],
      ),
    ));
  }
}
