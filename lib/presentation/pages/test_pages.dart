import 'package:apllication_book_now/presentation/widgets/container_date.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TestPages extends StatefulWidget {
  const TestPages({super.key});

  @override
  State<TestPages> createState() => _TestPagesState();
}

class _TestPagesState extends State<TestPages> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header("Pengaturan"),
      body: SafeArea(
        child: Padding(
          padding: sidePaddingBig,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // informationText(
              //     "assets/image/splash_screen/splash1.svg",
              //     "Kemudahan menanti anda",
              //     "Pesan layanan dengan cepat da tunggu pemberitahuan lebih lanjut untuk menikmati layanan terbaik kami!"),
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
              })
            ],
          ),
        ),
      ),
    );
  }
}
