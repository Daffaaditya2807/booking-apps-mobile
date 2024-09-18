import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../resource/sizes/list_padding.dart';

Widget selectedDateContainer(
    DateTime focusedDay,
    Function(DateTime focusedDay) pageChanged,
    Function(DateTime selectedDay, DateTime focusedDat) daySelected,
    bool Function(DateTime day) selectedPredicate) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: blueSecondary, width: 2.0),
      borderRadius: borderRoundedBig,
    ),
    child: TableCalendar(
      focusedDay: focusedDay,
      selectedDayPredicate: selectedPredicate,
      onDaySelected: daySelected,
      onPageChanged: pageChanged,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      rowHeight: 50,
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle:
            semiBoldStyle.copyWith(fontSize: 16, color: Colors.black),
        formatButtonVisible: false,
        leftChevronPadding: const EdgeInsets.all(0),
        headerPadding: verticalPaddingBig,
        leftChevronMargin: sidePaddingMedium,
        rightChevronPadding: const EdgeInsets.all(0),
        rightChevronMargin: sidePaddingMedium,
        leftChevronIcon: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: roundedMediumGeo),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.chevron_left,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        rightChevronIcon: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: roundedMediumGeo),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.chevron_right,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        decoration: const BoxDecoration(
            // color: Colors.white,
            ),
      ),
      calendarStyle: CalendarStyle(
        outsideDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        todayTextStyle: GoogleFonts.montserrat(
            color: Colors.white, fontWeight: FontWeight.bold),
        todayDecoration: BoxDecoration(
          color: blueSecondary,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: GoogleFonts.montserrat(color: Colors.white),
        defaultTextStyle: GoogleFonts.montserrat(),
        outsideTextStyle: GoogleFonts.montserrat(color: greyPrimary),
        holidayTextStyle: GoogleFonts.montserrat(color: Colors.redAccent),
        selectedDecoration: BoxDecoration(
          color: bluePrimary,
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}
