import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../resource/sizes/list_padding.dart';

Widget selectedDateContainer(
    DateTime focusedDay,
    Function(DateTime) pageChanged,
    Function(DateTime, DateTime) daySelected,
    bool Function(DateTime) isSelectable) {
  final DateTime currentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  return Container(
    decoration: BoxDecoration(
        borderRadius: borderRoundedBig, border: Border.all(color: blueTersier)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TableCalendar(
        focusedDay: focusedDay,
        locale: 'id',
        // calendarBuilders: CalendarBuilders(
        //   dowBuilder: (context, day) {
        //     if (day.weekday == DateTime.sunday) {
        //       return Center(
        //         child: Text(
        //           DateFormat.E().format(day),
        //           style: regularStyle.copyWith(
        //               color: Colors.red, fontWeight: FontWeight.bold),
        //         ),
        //       );
        //     }
        //     return null;
        //   },
        // ),
        selectedDayPredicate: (day) => isSameDay(day, focusedDay),
        onDaySelected: daySelected,
        sixWeekMonthsEnforced: true,
        onPageChanged: pageChanged,
        availableGestures: AvailableGestures.horizontalSwipe,
        startingDayOfWeek: StartingDayOfWeek.monday,
        enabledDayPredicate: isSelectable,
        firstDay: currentMonth,
        lastDay: DateTime.utc(2030, 3, 14),
        rowHeight: 45,
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextStyle:
              semiBoldStyle.copyWith(fontSize: fonth5, color: Colors.black),
          formatButtonVisible: false,
          leftChevronPadding: const EdgeInsets.all(0),
          headerPadding: verticalPaddingBig,
          leftChevronMargin: sidePaddingMedium,
          rightChevronPadding: const EdgeInsets.all(0),
          rightChevronMargin: sidePaddingMedium,
          leftChevronIcon: Container(
            decoration: BoxDecoration(
                color: isSameMonth(focusedDay, currentMonth)
                    ? greyTersier
                    : yellowActive,
                borderRadius: roundedMediumGeo),
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
                color: yellowActive, borderRadius: roundedMediumGeo),
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
          todayTextStyle: GoogleFonts.montserrat(color: Colors.black),
          todayDecoration: BoxDecoration(
            border: Border.all(color: yellowActive),
            shape: BoxShape.circle,
          ),
          disabledTextStyle: GoogleFonts.montserrat(color: Colors.black45),
          selectedTextStyle: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.bold),
          defaultTextStyle: GoogleFonts.montserrat(),
          outsideTextStyle: semiBoldStyle.copyWith(color: blueTersier),
          holidayTextStyle: GoogleFonts.montserrat(color: Colors.redAccent),
          selectedDecoration: BoxDecoration(
            color: yellowActive,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ),
  );
}

bool isSameMonth(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month;
}
