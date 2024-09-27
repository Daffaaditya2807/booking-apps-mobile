import 'package:apllication_book_now/presentation/state_management/controller_dashboard.dart';
import 'package:apllication_book_now/presentation/widgets/banner.dart';
import 'package:apllication_book_now/presentation/widgets/carousel.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/presentation/widgets/queue_number.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Map<String, dynamic> listLayanan = {
    "layanan": ["Layanan 1", "Layanan 2", "Layanan 3"],
    "warna": [const Color.fromRGBO(197, 217, 255, 1), yellowActive, bluePrimary]
  };

  List<BarChartGroupData> _buildBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: 25,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 15,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 20,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: 28,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 20,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 18,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: 35,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 30,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 22,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: 22,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 26,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 25,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
              toY: 40,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 30,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 35,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
              toY: 30,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 20,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 15,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
              toY: 15,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 25,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 10,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
      BarChartGroupData(
        x: 7,
        barRods: [
          BarChartRodData(
              toY: 35,
              color: const Color.fromRGBO(197, 217, 255, 1),
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 40,
              color: yellowActive,
              borderRadius: BorderRadius.circular(0)),
          BarChartRodData(
              toY: 30,
              color: bluePrimary,
              borderRadius: BorderRadius.circular(0)),
        ],
        showingTooltipIndicators: [],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double heightAppBar = MediaQuery.of(context).viewPadding.top;
    double heightScreen = MediaQuery.sizeOf(context).height;
    double heightContainer =
        (heightScreen - kToolbarHeight - heightAppBar) * 0.25;

    controllerDashboard.idUsers.value =
        controllerLogin.user.value!.idUsers.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildDashboardPage(
          heightContainer, context, controllerLogin.user.value!.namaPembeli),
    );
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
            child: Obx(() {
              if (controllerDashboard.isLoading.value) {
                return loadingData("mengambil data tiket");
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
                              data.noLoket,
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
          Padding(
            padding: sidePaddingBig,
            child: Container(
              width: double.infinity,
              height: 170,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 40,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          TextStyle style = regularStyle.copyWith(
                              fontSize: 12, color: Colors.black);
                          Widget text;
                          switch (value.toInt()) {
                            case 0:
                              text = Text('08.00', style: style);
                              break;
                            case 1:
                              text = Text('09.00', style: style);
                              break;
                            case 2:
                              text = Text('10.00', style: style);
                              break;
                            case 3:
                              text = Text('11.00', style: style);
                              break;
                            case 4:
                              text = Text('12.00', style: style);
                              break;
                            case 5:
                              text = Text('13.00', style: style);
                              break;
                            case 6:
                              text = Text('14.00', style: style);
                              break;
                            case 7:
                              text = Text('15.00', style: style);
                              break;
                            default:
                              text = Text('', style: style);
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 2.0,
                            child: text,
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(value.toInt().toString(),
                              style: regularStyle.copyWith(
                                  fontSize: 10, color: Colors.black),
                              textAlign: TextAlign.left);
                        },
                        reservedSize: 28,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  barGroups: _buildBarGroups(),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ),
          spaceHeightMedium,
          Padding(
            padding: sidePaddingBig,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return colourIndicatorService(
                    listLayanan['layanan'][index], listLayanan['warna'][index]);
              },
            ),
          ),
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
                  child: Hero(
                    tag: 'dashboard-${services.image}',
                    child: serviceCard(context, services.name,
                        services.description, services.image),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
