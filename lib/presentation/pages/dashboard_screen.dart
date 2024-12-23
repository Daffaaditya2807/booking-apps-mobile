import 'dart:developer';

import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/state_management/controller_dashboard.dart';
import 'package:apllication_book_now/presentation/widgets/banner.dart';
import 'package:apllication_book_now/presentation/widgets/carousel.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/presentation/widgets/queue_number.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/routes/routes.dart';
import '../../resource/sizes/list_rounded.dart';
import '../state_management/controller_dicebear.dart';
import '../state_management/controller_get_service.dart';
import '../state_management/controller_login.dart';
import '../widgets/list_service.dart';
import '../widgets/list_text.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final ControllerDashboard controllerDashboard =
      Get.put(ControllerDashboard());
  final DiceBearController diceBearController = Get.put(DiceBearController());
  final ControllerLogin controllerLogin =
      Get.put(ControllerLogin(), permanent: true);
  final ControllerGetService controllerGetService =
      Get.put(ControllerGetService());

  @override
  Widget build(BuildContext context) {
    double heightAppBar = MediaQuery.of(context).viewPadding.top;
    double heightScreen = MediaQuery.sizeOf(context).height;
    double heightContainer =
        (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controllerDashboard.fetchGetTicketUser(
                controllerLogin.user.value!.idUsers.toString());
            controllerDashboard.fetchChartData();
            controllerGetService.fetchService();
            controllerDashboard.assignAllHistoryLast(
                controllerLogin.user.value!.idUsers.toString());
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                elevation: 0,
                surfaceTintColor: Colors.white,
                toolbarHeight: kToolbarHeight + 30,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  // expandedTitleScale: 120.0,
                  background: Padding(
                    padding: sidePaddingBig,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: componentTextGreeting(
                              controllerLogin.user.value?.namaPembeli ?? ''),
                        ),
                        Obx(() {
                          return controllerLogin.user.value == null
                              ? const CircularProgressIndicator()
                              : Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: greyTersier,
                                        width: 1.0,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipOval(
                                      child: SvgPicture.network(
                                        controllerLogin.user.value!.avatarUrl,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                );
                        })
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _buildDashboardPage(heightContainer, context),
              )
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _buildDashboardPage(double heightContainer, BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // spaceHeightBig,
          Padding(
            padding: sidePaddingBig,
            child: Obx(() => controllerDashboard.ticketUser.isEmpty
                ? Container()
                : componenTextHeaderDesc("Nomor Antrian Anda",
                    "Nomor antrian yang terdapat pada hari ini",
                    warna: blueTersier)),
          ),
          spaceHeightSmall,
          Padding(
            padding: sidePaddingBig,
            child: Obx(() {
              if (controllerDashboard.isLoading.value) {
                return loadingData("mengambil data tiket");
              } else if (controllerDashboard.ticketUser.isEmpty) {
                return Container();
              } else {
                return SizedBox(
                  height: heightContainer * 0.7,
                  child: ListView.builder(
                    itemCount: controllerDashboard.ticketUser.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = controllerDashboard.ticketUser[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 60,
                            child: queueNumberUser(
                              data.nomorBooking,
                              data.jamBooking,
                              data.layanan.name,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),

          Obx(() => controllerDashboard.ticketUser.isEmpty ||
                  controllerDashboard.ticketUser.length == 1
              ? Container()
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Geser kanan untuk melihat nomor antrian lainnya",
                    style: regularStyle.copyWith(
                        fontSize: smallFont, color: Colors.black),
                  ),
                )),
          spaceHeightBig,
          Padding(
            padding: sidePaddingBig,
            child: componenTextHeaderDesc(
                "Kepadatan Antrian", "Segera booking layanan anda",
                warna: blueTersier),
          ),
          // spaceHeightBig,
          _buildDatePicker(),
          spaceHeightBig,
          spaceHeightMedium,
          Obx(() {
            if (controllerDashboard.isLoadingChart.value) {
              return loadingData('memuat data chart');
            } else {
              return controllerDashboard.maxY.value == 0
                  ? Center(
                      child: Text(
                        "Belum terdapat antrian",
                        style: semiBoldStyle.copyWith(color: Colors.black),
                      ),
                    )
                  : Padding(
                      padding: sidePaddingBig,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: calculateTotalWidth(),
                          height: heightContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: BarChart(
                              BarChartData(
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: controllerDashboard.maxY.value + 1,
                                  minY: 0,
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                        getTitlesWidget: (double value, _) {
                                          TextStyle style =
                                              regularStyle.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.black);
                                          List<String> jamLayanan =
                                              controllerDashboard.jamLayanan;
                                          if (value.toInt() <
                                              jamLayanan.length) {
                                            return Text(
                                              jamLayanan[value.toInt()],
                                              style: style,
                                            );
                                          } else {
                                            return Text(
                                              '',
                                              style: style,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        getTitlesWidget:
                                            (double value, TitleMeta meta) {
                                          return Text(value.toInt().toString(),
                                              style: regularStyle.copyWith(
                                                  fontSize: smallFont,
                                                  color: Colors.black),
                                              textAlign: TextAlign.left);
                                        },
                                        reservedSize: 10,
                                      ),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  barGroups: controllerDashboard.barGroups,
                                  gridData: const FlGridData(show: true),
                                  barTouchData: BarTouchData(
                                      enabled: false,
                                      touchTooltipData: BarTouchTooltipData(
                                        getTooltipColor: (group) =>
                                            Colors.transparent,
                                        tooltipPadding: EdgeInsets.zero,
                                        tooltipMargin: 8,
                                        getTooltipItem:
                                            (BarChartGroupData group,
                                                int groupIndex,
                                                BarChartRodData rod,
                                                int rodIndex) {
                                          return rod.toY == 0
                                              ? null
                                              : BarTooltipItem(
                                                  rod.toY.round().toString(),
                                                  regularStyle.copyWith(
                                                      color: greyPrimary));
                                        },
                                      ))),
                            ),
                          ),
                        ),
                      ),
                    );
            }
          }),
          spaceHeightSmall,
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: sidePaddingBig,
              child: Obx(() => Text(
                    "Tanggal : ${DateFormat('dd MMMM yyyy', 'id').format(DateTime.parse(controllerDashboard.selectedDate.value.toString()))}",
                    textAlign: TextAlign.center,
                    style: regularStyle.copyWith(
                        color: Colors.black, fontSize: regularFont),
                  )),
            ),
          ),
          spaceHeightMedium,
          Obx(() => Padding(
                padding: sidePaddingBig,
                child: ListView.builder(
                  itemCount: controllerDashboard.layanan.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int serviceId =
                        controllerDashboard.layanan[index]['id_layanan'];
                    String namaLayanan =
                        controllerDashboard.layanan[index]['nama_layanan'];
                    Color serviceColor =
                        controllerDashboard.getColorForService(serviceId);
                    return colourIndicatorService(
                      namaLayanan,
                      serviceColor,
                    );
                  },
                ),
              )),
          spaceHeightMedium,
          Obx(() => listWidget(context).isEmpty
              ? Container()
              : carouselSlider(
                  _controller,
                  heightContainer,
                  (index, reason) => controllerDashboard.getIndex(index),
                  listWidget(context))),
          Center(
            child: Obx(() => listWidget(context).isEmpty
                ? Container()
                : indicatorCarousel(controllerDashboard.currentIndex.value,
                    listWidget(context), _controller)),
          ),
          spaceHeightBig,
          Obx(() => controllerDashboard.historyLast.isEmpty
              ? Container()
              : Padding(
                  padding: sidePaddingBig,
                  child: componenTextHeaderDesc(
                    "Pesanan Baru Dibuat",
                    "Menampilkan 3 Pesanan yang baru dibuat",
                    warna: blueTersier,
                  ),
                )),
          Obx(() {
            if (controllerDashboard.isLoadingHistory.value) {
              return loadingData("memuat data");
            } else {
              return ListView.builder(
                itemCount: controllerDashboard.historyLast.length > 3
                    ? 3
                    : controllerDashboard.historyLast.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final historyService = controllerDashboard.historyLast[index];
                  return InkWell(
                    onTap: () {
                      log("halo");
                      Get.toNamed(Routes.serviceStatusScreen,
                          arguments: historyService);
                    },
                    child: Padding(
                      padding: sidePaddingBig,
                      child: historyServiceCardDashboard(
                          context,
                          historyService.layanan.name,
                          historyService.layanan.description,
                          '$apiImage${historyService.layanan.image}',
                          historyService.tanggal,
                          historyService.nomorBooking,
                          historyService.jamBooking,
                          historyService.status),
                    ),
                  );
                },
              );
            }
          }),
          spaceHeightMedium,
          Padding(
            padding: sidePaddingBig,
            child: componenTextHeaderDesc(
              "Layanan",
              "Silakan memilih salah layanan yang tersedia",
              warna: blueTersier,
            ),
          ),
          spaceHeightBig,
          Padding(
            padding: sidePaddingBig,
            child:
                serviceCardGridView(context, controllerGetService.serviceList),
          ),
          spaceHeightBig
        ],
      ),
    ));
  }

  List<Widget> listWidget(BuildContext context) =>
      List.generate(controllerDashboard.urlImagee.length, (int index) {
        final listUrl = controllerDashboard.urlImagee[index];
        if (listUrl != null) {
          return containerBanner2(context, listUrl);
        } else {
          return Container(
            color: Colors.blue,
          );
        }
      });

  double calculateTotalWidth() {
    double totalWidth = MediaQuery.sizeOf(context).width;
    for (var group in controllerDashboard.barGroups) {
      totalWidth +=
          group.barRods.length * 10; // 40.0 adalah lebar rata-rata per bar
    }
    return totalWidth;
  }

  void showMonthPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pilih Tanggal Untuk Melihat Antrian',
            textAlign: TextAlign.center,
            style: regularStyle.copyWith(
                color: Colors.black, fontSize: regularFont),
          ),
          content: SizedBox(
            width: double.infinity,
            child: Obx(() => DayPicker.single(
                selectedDate: controllerDashboard.selectedDate.value,
                onChanged: controllerDashboard.onSelectedDateChanged,
                firstDate: controllerDashboard.firstDate,
                lastDate: controllerDashboard.lastDate,
                datePickerStyles: DatePickerRangeStyles(
                    nextIcon: Container(
                      decoration: BoxDecoration(
                          color: yellowActive, borderRadius: roundedMediumGeo),
                      child: const Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Icon(
                          Icons.chevron_right,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    prevIcon: Container(
                      decoration: BoxDecoration(
                          color: yellowActive, borderRadius: roundedMediumGeo),
                      child: const Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Icon(
                          Icons.chevron_left,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    dayHeaderStyle: DayHeaderStyle(
                        textStyle: semiBoldStyle.copyWith(color: Colors.black)),
                    displayedPeriodTitle:
                        semiBoldStyle.copyWith(color: Colors.black),
                    selectedSingleDateDecoration: BoxDecoration(
                        color: yellowActive, shape: BoxShape.circle),
                    selectedDateStyle:
                        boldStyle.copyWith(color: Colors.white)))),
          ),
          actions: [
            Column(
              children: [
                Obx(() => Align(
                    alignment: Alignment.center,
                    child: controllerDashboard.selectedDateNull.value == null
                        ? Container()
                        : Text(
                            DateFormat('dd MMMM yyyy', 'id')
                                .format(controllerDashboard.selectedDate.value),
                            style: semiBoldStyle.copyWith(color: blueTersier),
                          ))),
                miniButtonPrimary("OK", () => Navigator.of(context).pop())
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: sidePaddingBig,
      child: Row(
        children: [
          // spaceWidthMedium,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Obx(() => InkWell(
                    onTap: () async {
                      showMonthPicker(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today, color: blueTersier),
                        spaceWidthMedium,
                        Text(
                          controllerDashboard.selectedDateNull.value != null
                              ? DateFormat('dd MMMM yyyy').format(
                                  controllerDashboard.selectedDate.value)
                              : 'Pilih Tanggal',
                          style: semiBoldStyle.copyWith(
                            fontSize: regularFont,
                            color: blueTersier,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Obx(() => controllerDashboard.selectedDateNull.value != null
              ? IconButton(
                  onPressed: () => controllerDashboard.resetDate(),
                  icon: Icon(Icons.close, color: blueTersier),
                )
              : Container())
        ],
      ),
    );
  }
}
