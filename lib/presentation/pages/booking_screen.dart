import 'package:apllication_book_now/presentation/widgets/clock_inputs.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/routes/routes.dart';
import '../widgets/container_date.dart';
import '../widgets/header.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithIcon("Pesan Layanan"),
      body: _buildPageBookingScreen(),
    );
  }

  SafeArea _buildPageBookingScreen() {
    return SafeArea(
      child: Padding(
        padding: sidePaddingBig,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeightBig,
              selectedDateContainer(_focusedDay, (focuseDay) {
                setState(() {
                  _focusedDay = focuseDay;
                });
              }, (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }, (day) {
                return isSameDay(_selectedDay, day);
              }),
              spaceHeightBig,
              const Divider(),
              spaceHeightBig,
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.center,
                spacing: 15.0,
                runSpacing: 10.0,
                children: [
                  availableTime("08:00"),
                  availableTime("08:00"),
                  selectedTime("08:00"),
                  availableTime("08:00"),
                  nonAvailableTime("08:00"),
                  availableTime("08:00"),
                  availableTime("08:00"),
                  availableTime("08:00"),
                  availableTime("08:00"),
                  availableTime("08:00"),
                  availableTime("08:00"),
                ],
              ),
              spaceHeightBig,
              componentTextDetailBooking(
                  "Senin", "9 September 2024", "09:30", "Layanan 1"),
              spaceHeightBig,
              buttonPrimary("Booking", () {
                Get.toNamed(Routes.bookingDoneScreen);
              }),
              spaceHeightBig
            ],
          ),
        ),
      ),
    );
  }
}
