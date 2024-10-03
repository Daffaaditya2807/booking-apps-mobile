import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/presentation/state_management/controller_dashboard.dart';
import 'package:apllication_book_now/presentation/widgets/banner.dart';
import 'package:apllication_book_now/presentation/widgets/carousel.dart';
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
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/routes/routes.dart';
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
  // final ControllerDashboard controllerDashboard = Get.find<ControllerDashboard>();

  final ControllerLogin controllerLogin =
      Get.put(ControllerLogin(), permanent: true);
  final ControllerGetService controllerGetService =
      Get.put(ControllerGetService());

  List<Widget> listWidget(BuildContext context) => [
        containerBanner2(context),
        containerBanner2(context),
        containerBanner2(context),
        containerBanner2(context),
      ];
  @override
  Widget build(BuildContext context) {
    double heightAppBar = MediaQuery.of(context).viewPadding.top;
    double heightScreen = MediaQuery.sizeOf(context).height;
    double heightContainer =
        (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildDashboardPage(heightContainer, context,
          controllerLogin.user.value?.namaPembeli ?? ''),
    );
  }

  double calculateTotalWidth() {
    double totalWidth = MediaQuery.sizeOf(context).width;
    for (var group in controllerDashboard.barGroups) {
      totalWidth +=
          group.barRods.length * 10; // 40.0 adalah lebar rata-rata per bar
    }
    return totalWidth;
  }

  SafeArea _buildDashboardPage(
      double heightContainer, BuildContext context, String nameUser) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeightBig,
          Padding(
            padding: sidePaddingBig,
            child: componentTextGreeting("$nameUser!"),
          ),
          spaceHeightBig,
          carouselSlider(
              _controller,
              heightContainer,
              (index, reason) => controllerDashboard.getIndex(index),
              listWidget(context)),
          Center(
            child: Obx(() => indicatorCarousel(
                controllerDashboard.currentIndex.value,
                listWidget(context),
                _controller)),
          ),
          spaceHeightBig,
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
          spaceHeightMedium,
          Padding(
            padding: sidePaddingBig,
            child: componenTextHeaderDesc(
                "Kepadatan Antrian", "Segera booking layanan anda",
                warna: blueTersier),
          ),
          spaceHeightBig,
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
                                        TextStyle style = regularStyle.copyWith(
                                            fontSize: 12, color: Colors.black);
                                        List<String> jamLayanan =
                                            controllerDashboard.jamLayanan;
                                        if (value.toInt() < jamLayanan.length) {
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
                              ),
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
              child: Text(
                "Tanggal : ${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
                textAlign: TextAlign.center,
                style: regularStyle.copyWith(
                    color: Colors.black, fontSize: regularFont),
              ),
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
          Padding(
            padding: sidePaddingBig,
            child: ListView.builder(
              itemCount: controllerGetService.serviceList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final services = controllerGetService.serviceList[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.bookingScreen, arguments: services);
                  },
                  child: serviceCard(context, services.name,
                      services.description, '$apiImage${services.image}'),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
