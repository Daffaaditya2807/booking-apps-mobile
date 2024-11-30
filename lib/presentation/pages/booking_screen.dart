import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/models/service_model.dart';
import 'package:apllication_book_now/presentation/state_management/controller_booking.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:apllication_book_now/presentation/widgets/clock_inputs.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/container_date.dart';
import '../widgets/header.dart';
import '../widgets/list_service.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final ControllerBooking controllerBooking = Get.put(ControllerBooking());
  final ControllerLogin controllerUser =
      Get.put(ControllerLogin(), permanent: true);
  final services = Get.arguments as ServiceModel;

  @override
  Widget build(BuildContext context) {
    controllerBooking.serviceId.value = services.id;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithIcon("Pesan Layanan", backgroundColor: Colors.white),
      body: _buildPageBookingScreen(context),
    );
  }

  String hari(String tanggal) {
    DateTime parsedDate = DateTime.parse(tanggal);
    String convHari = DateFormat('EEEE').format(parsedDate);
    return convHari;
  }

  String tanggal(String tanggal) {
    DateTime parsedDate = DateTime.parse(tanggal);
    String convTanggal = DateFormat('dd-MM-yyyy').format(parsedDate);
    return convTanggal;
  }

  SafeArea _buildPageBookingScreen(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: sidePaddingBig,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeightBig,
              ExpansionTile(
                title: Text(
                  services.name,
                  style: semiBoldStyle.copyWith(
                      color: bluePrimary, fontSize: fonth5),
                ),
                tilePadding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(),
                subtitle: Text(
                  "Baca lebih lanjut untuk deskripsi layanan",
                  style: regularStyle.copyWith(
                      color: Colors.black, fontSize: smallFont),
                ),
                children: [
                  detailService(
                      context,
                      services.name,
                      services.description,
                      '$apiImage${services.image}',
                      '${Get.currentRoute.split('/').last}-${services.image}'),
                ],
              ),
              spaceHeightBig,
              const Divider(),
              spaceHeightBig,
              componentTextHeader("Tentukan Tanggal Booking", size: fonth5),
              spaceHeightMedium,
              Obx(() => selectedDateContainer(
                      controllerBooking.focusedDay.value,
                      controllerBooking.changeFocusedDay,
                      (selectedDay, focusedDay) {
                    if (controllerBooking.isSelectable(selectedDay)) {
                      if (!controllerBooking.isLoadingLoket.value) {
                        if (!controllerBooking.isSameMonth(
                            selectedDay, focusedDay)) {
                          controllerBooking.changeFocusedDay(DateTime(
                              selectedDay.year,
                              selectedDay.month,
                              selectedDay.day));
                        } else {
                          controllerBooking.changeFocusedDay(focusedDay);
                        }
                        controllerBooking.changeSelectedDay(selectedDay);
                      }
                    }
                  }, controllerBooking.isSelectable)),
              spaceHeightBig,
              const Divider(),
              Obx(() => controllerBooking.times.isNotEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Pilih Jam Layanan",
                        style: regularStyle.copyWith(color: Colors.black),
                      ),
                    )
                  : Container()),
              spaceHeightMedium,
              Obx(() => controllerBooking.isLoading.value &&
                      controllerBooking.isFirstLoadValue.value
                  ? loadingData("memuat daftar jam...")
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: controllerBooking.times.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var timeEntry = controllerBooking.times[index];

                        DateTime currenTime = DateTime.now();
                        DateTime availableTimess = DateTime.parse(
                            '${controllerBooking.selectedDay.value!.toIso8601String().split('T')[0]} ${timeEntry['time']}:00');
                        int differenceInMinutes =
                            availableTimess.difference(currenTime).inMinutes;
                        bool isTimeValid =
                            availableTimess.isAfter(currenTime) &&
                                differenceInMinutes > 20;

                        // String waktuKepilih =
                        //     '${controllerBooking.selectedDay.value!.toIso8601String().split('T')[0]} ${timeEntry['time']}:00';
                        // String waktuSekarang = currenTime.toString();
                        // print(
                        //     "waktu kepilih $waktuKepilih dan Waktu sekarang $waktuSekarang");
                        return Obx(() {
                          bool isSelected =
                              controllerBooking.selectedTime.value ==
                                      timeEntry['time'] &&
                                  timeEntry['available'] &&
                                  isTimeValid;

                          return InkWell(
                            onTap: () {
                              if (timeEntry['available'] && isTimeValid) {
                                controllerBooking.selectedTime.value =
                                    timeEntry['time'];
                                controllerBooking.jamBooking.value =
                                    timeEntry['time'];
                                controllerBooking.selectedLocket.value = '';
                                int slotTersedia = timeEntry['remaining_slots'];
                                controllerBooking.availableSlots.value =
                                    slotTersedia;
                                // controllerBooking.fetchAvailableLoket();
                              }
                            },
                            child: isSelected
                                ? selectedTime(timeEntry['time'])
                                : timeEntry['available'] && isTimeValid
                                    ? availableTime(timeEntry['time'])
                                    : nonAvailableTime(timeEntry['time']),
                          );
                        });
                      },
                    )),
              spaceHeightMedium,
              Obx(() => controllerBooking.availableSlots.value != 0
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                            text: "Sisa loket tersedia :",
                            style: regularStyle.copyWith(color: Colors.black),
                            children: [
                              TextSpan(
                                  text:
                                      " ${controllerBooking.availableSlots.value}",
                                  style: semiBoldStyle.copyWith(
                                      color: bluePrimary))
                            ]),
                      ))
                  : Container()),
              spaceHeightBig,
              Obx(() => buttonPrimary("Booking",
                      color: controllerBooking.selectedTime.value.isEmpty
                          ? [Colors.grey.shade300, Colors.grey.shade200]
                          : [bluePrimary, blueSecondary], () {
                    String chooseLocket =
                        controllerBooking.selectedLocket.value;
                    String idLayanan = services.id.toString();
                    String jamBooking = controllerBooking.selectedTime.value;
                    String tanggalBooking =
                        controllerBooking.selectedDay.value.toString();
                    String idUser =
                        controllerUser.user.value!.idUsers.toString();
                    if (jamBooking != '' && idLayanan.isNotEmpty) {
                      Get.defaultDialog(
                          title: "Konfirmasi Booking",
                          barrierDismissible: false,
                          titleStyle: semiBoldStyle.copyWith(
                              color: bluePrimary, fontSize: fonth4),
                          content: Padding(
                            padding: sidePaddingBig,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Layanan",
                                      style: semiBoldStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      services.name,
                                      style: regularStyle.copyWith(
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tanggal",
                                      style: semiBoldStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      tanggal(tanggalBooking),
                                      style: regularStyle.copyWith(
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Jam",
                                      style: semiBoldStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      jamBooking,
                                      style: regularStyle.copyWith(
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                spaceHeightSmall,
                                const Divider(),
                                Obx(() => controllerBooking.isLoading.value
                                    ? loadingData("mengirim data")
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: miniButtonOutline("Batal",
                                                  () {
                                            Get.back();
                                          })),
                                          spaceWidthMedium,
                                          Expanded(
                                              child:
                                                  miniButtonPrimary("Buat", () {
                                            print(
                                                "Loketnya adalah = $chooseLocket\nId Layanan = $idLayanan\nJam Booking = $jamBooking\ntanggal = $tanggalBooking\nId User = $idUser");
                                            DateTime dateFormat =
                                                DateTime.parse(tanggalBooking);
                                            String formateDate =
                                                DateFormat('yyyy-MM-dd', 'id')
                                                    .format(dateFormat);

                                            controllerBooking.insertBooking(
                                                alamat: "Bluru Kidul",
                                                idLayanan: idLayanan,
                                                jamBooking: jamBooking,
                                                tanggal: formateDate,
                                                idUser: idUser,
                                                layanan: services.name);
                                          })),
                                        ],
                                      )),
                              ],
                            ),
                          ));
                    } else {
                      snackBarError("Lengkapi Data",
                          "Harap lengkapi data booking terlebih dahulu");
                    }
                  })),
              spaceHeightBig
            ],
          ),
        ),
      ),
    );
  }
}
