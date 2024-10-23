import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../data/data_sources/api.dart';
import '../state_management/controller_login.dart';
import '../widgets/list_service.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  final ControllerStatusScreen controllerStatusScreen =
      Get.put(ControllerStatusScreen());
  final ControllerLogin controllerUser =
      Get.put(ControllerLogin(), permanent: true);
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  String? selectedMonth;
  int? selectedYear;

  List<Tab> menuTab = [
    const Tab(
      text: "Dipesan",
    ),
    const Tab(
      text: "Diproses",
    ),
    const Tab(
      text: "Dibatalkan",
    ),
    const Tab(
      text: "Selesai",
    )
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 4);
    // controller?.addListener(_handleTabSelection);
    controller?.addListener(() {
      // Update active tab index when tab changes
      controllerStatusScreen.activeTabIndex.value = controller?.index ?? 0;
    });
    _loadData();
    controllerStatusScreen.idUsers.value =
        controllerUser.user.value!.idUsers.toString();
  }

  void _loadData() {
    controllerStatusScreen
        .assignAllHistoryPesan(controllerUser.user.value!.idUsers.toString());
    controllerStatusScreen
        .assignAllHistoryProses(controllerUser.user.value!.idUsers.toString());
    controllerStatusScreen
        .assignHistoryDitolak(controllerUser.user.value!.idUsers.toString());
    controllerStatusScreen
        .assignHistorySelesai(controllerUser.user.value!.idUsers.toString());
  }

  Future<void> _onRefresh() async {
    refreshKey.currentState?.show(atTop: false);
    _loadData();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesTest = [
      Obx(() {
        if (controllerStatusScreen.isLoadingPesan.value) {
          return Column(
            children: [
              Expanded(child: Container()),
              loadingData("memuat history"),
              Expanded(child: Container()),
            ],
          );
        } else {
          return controllerStatusScreen.historyPesan.isEmpty
              ? emptyListService()
              : ListView.builder(
                  itemCount: controllerStatusScreen.historyPesan.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print(
                        "Panjang Data Pesan = ${controllerStatusScreen.historyPesan.length}");
                    final historyPesann =
                        controllerStatusScreen.historyPesan[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historyPesann);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: historyServiceCard(
                            context,
                            historyPesann.layanan.name,
                            historyPesann.layanan.description,
                            '$apiImage${historyPesann.layanan.image}',
                            historyPesann.tanggal,
                            historyPesann.nomorBooking,
                            historyPesann.jamBooking),
                      ),
                    );
                  },
                );
        }
      }),
      Obx(() {
        if (controllerStatusScreen.isLoadingProses.value) {
          return Column(
            children: [
              Expanded(child: Container()),
              loadingData("memuat history"),
              Expanded(child: Container()),
            ],
          );
        } else {
          return controllerStatusScreen.historyProses.isEmpty
              ? emptyListService()
              : ListView.builder(
                  itemCount: controllerStatusScreen.historyProses.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print(
                        "Panjang Data Proses = ${controllerStatusScreen.historyProses.length}");
                    final historyProses =
                        controllerStatusScreen.historyProses[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historyProses);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: historyServiceCard(
                            context,
                            historyProses.layanan.name,
                            historyProses.layanan.description,
                            '$apiImage${historyProses.layanan.image}',
                            historyProses.tanggal,
                            historyProses.nomorBooking,
                            historyProses.jamBooking),
                      ),
                    );
                  },
                );
        }
      }),
      Obx(() {
        if (controllerStatusScreen.isLoadingTolak.value) {
          return Column(
            children: [
              Expanded(child: Container()),
              loadingData("memuat history"),
              Expanded(child: Container()),
            ],
          );
        } else {
          return controllerStatusScreen.historyTolak.isEmpty
              ? emptyListService()
              : ListView.builder(
                  itemCount: controllerStatusScreen.historyTolak.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print(
                        "Panjang Data Tolak = ${controllerStatusScreen.historyTolak.length}");
                    final historyTolak =
                        controllerStatusScreen.historyTolak[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historyTolak);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: historyServiceCard(
                            context,
                            historyTolak.layanan.name,
                            historyTolak.layanan.description,
                            '$apiImage${historyTolak.layanan.image}',
                            historyTolak.tanggal,
                            historyTolak.nomorBooking,
                            historyTolak.jamBooking),
                      ),
                    );
                  },
                );
        }
      }),
      Obx(() {
        if (controllerStatusScreen.isLoadingSelesai.value) {
          return Column(
            children: [
              Expanded(child: Container()),
              loadingData("memuat history"),
              Expanded(child: Container()),
            ],
          );
        } else {
          return controllerStatusScreen.historySelesai.isEmpty
              ? emptyListService()
              : ListView.builder(
                  itemCount: controllerStatusScreen.historySelesai.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print(
                        "Panjang Data Selesai = ${controllerStatusScreen.historySelesai.length}");
                    final historySelesai =
                        controllerStatusScreen.historySelesai[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historySelesai);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: historyServiceCard(
                            context,
                            historySelesai.layanan.name,
                            historySelesai.layanan.description,
                            '$apiImage${historySelesai.layanan.image}',
                            historySelesai.tanggal,
                            historySelesai.nomorBooking,
                            historySelesai.jamBooking),
                      ),
                    );
                  },
                );
        }
      }),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithTabBar("Status", controller!, menuTab),
      floatingActionButton: CircleAvatar(
        backgroundColor: bluePrimary,
        child: IconButton(
            color: Colors.white,
            onPressed: () {
              Get.bottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: roundedBig, topLeft: roundedBig),
                  ), GetBuilder<ControllerStatusScreen>(builder: (controller) {
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: sideVerticalPaddingBig,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceHeightSmall,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 130),
                            child: Container(
                              height: 5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: greyTersier,
                                  borderRadius: borderRoundedMedium),
                            ),
                          ),
                          spaceHeightMedium,
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Urutkan Data",
                              style: semiBoldStyle.copyWith(
                                  color: Colors.black, fontSize: fonth4),
                            ),
                          ),
                          spaceHeightMedium,
                          const Divider(),
                          Text(
                            "Layanan",
                            style: semiBoldStyle.copyWith(
                                color: Colors.black, fontSize: fonth4),
                          ),
                          Obx(() => ListView.builder(
                                itemCount: controller.getServiceList.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final servicess =
                                      controller.getServiceList[index];
                                  if (controller.selectedServices.length >
                                      index) {
                                    return CheckboxListTile(
                                      value: controller.selectedServices[index],
                                      splashRadius: 0,
                                      checkboxShape: RoundedRectangleBorder(
                                          borderRadius: roundedSmallGeo,
                                          side: BorderSide(color: greyTersier)),
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                      activeColor: bluePrimary,
                                      side: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1.5),
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text(
                                        servicess.name,
                                        style: regularStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: fonth6),
                                      ),
                                      onChanged: (value) {
                                        controller.selectedServices[index] =
                                            value ?? false;
                                        controller.update();
                                      },
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              )),
                          spaceHeightSmall,
                          Text(
                            "Tanggal",
                            style: semiBoldStyle.copyWith(
                                color: Colors.black, fontSize: fonth4),
                          ),
                          spaceHeightMedium,
                          Row(
                            children: [
                              Expanded(
                                  child: Obx(() => miniButtonOutline("Terbaru",
                                          bgColor:
                                              controller.selectedIndex.value ==
                                                      0
                                                  ? bluePrimary
                                                  : Colors.grey.shade400, () {
                                        controller.selectButton(0);
                                        controller.update;
                                        controller.valueDateFilter.value =
                                            'Data Terbaru';
                                      }))),
                              spaceWidthSmall,
                              Expanded(
                                  child: Obx(() => miniButtonOutline("Terlama",
                                          bgColor:
                                              controller.selectedIndex.value ==
                                                      1
                                                  ? bluePrimary
                                                  : Colors.grey.shade400, () {
                                        controller.selectButton(1);
                                        controller.update;
                                        controller.valueDateFilter.value =
                                            'Data Terlama';
                                      }))),
                              spaceWidthSmall,
                              Expanded(
                                  child: Obx(() => miniButtonOutline(
                                        "Bulan",
                                        bgColor:
                                            controller.selectedIndex.value == 2
                                                ? bluePrimary
                                                : Colors.grey.shade400,
                                        () {
                                          controller.selectButton(2);
                                          controller.update;
                                          showMonthPicker(context);
                                        },
                                      ))),
                              spaceWidthSmall,
                              Expanded(
                                  child: Obx(() => miniButtonOutline("Tanggal",
                                          bgColor:
                                              controller.selectedIndex.value ==
                                                      3
                                                  ? bluePrimary
                                                  : Colors.grey.shade400, () {
                                        controller.selectButton(3);
                                        controller.update;
                                        showDateRangePicker(context);
                                      })))
                            ],
                          ),
                          spaceHeightMedium,
                          Obx(() => controller.valueDateFilter.value == ''
                              ? Container()
                              : Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: roundedMediumGeo,
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(() => Text(
                                            controller.valueDateFilter.value,
                                            textAlign: TextAlign.center,
                                            style: semiBoldStyle.copyWith(
                                                color: Colors.black),
                                          )),
                                    ),
                                  ),
                                )),
                          spaceHeightMedium,
                          Row(
                            children: [
                              Expanded(
                                child: buttonPrimary("Terapkan", () {
                                  final selectedServices =
                                      controller.getSelectedServices();
                                  controller.filterHistoryData(
                                      selectedServices,
                                      controllerStatusScreen
                                          .valueDateFilter.value);
                                  print("Created At dates for current list:");
                                  controllerStatusScreen.historyPesan
                                      .forEach((item) {
                                    print(
                                        "${item.nomorBooking}: ${item.createdAt}");
                                  });
                                  Get.back();
                                }),
                              ),
                              spaceWidthMedium,
                              Container(
                                decoration: BoxDecoration(
                                    color: yellowActive,
                                    borderRadius: roundedMediumGeo),
                                child: Padding(
                                  padding: valuePaddingSmall,
                                  child: IconButton(
                                      onPressed: () {
                                        controllerStatusScreen.resetFilter();
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                        size: 30,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }));
            },
            icon: const Icon(CupertinoIcons.slider_horizontal_3)),
      ),
      body: bodyTabBar(pagesTest, controller!),
    );
  }

  void showMonthPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pilih Bulan dan Tahun',
            textAlign: TextAlign.center,
            style: regularStyle.copyWith(
                color: Colors.black, fontSize: regularFont),
          ),
          content: SizedBox(
            width: double.infinity,
            child: Obx(() => MonthPicker.single(
                selectedDate: controllerStatusScreen.selectedDate.value,
                onChanged: controllerStatusScreen.onSelectedDateChanged,
                firstDate: controllerStatusScreen.firstDate,
                lastDate: controllerStatusScreen.lastDate,
                datePickerStyles: DatePickerStyles(
                    selectedSingleDateDecoration: BoxDecoration(
                        color: bluePrimary, shape: BoxShape.circle)))),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog tanpa menyimpan
              },
              child: Text(
                'OK',
                style: semiBoldStyle.copyWith(color: bluePrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDateRangePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pilih Rentang Tanggal',
            textAlign: TextAlign.center,
            style: regularStyle.copyWith(
                color: Colors.black, fontSize: regularFont),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Obx(() => RangePicker(
                  selectedPeriod: controllerStatusScreen.getSelectedPeriod,
                  onChanged: controllerStatusScreen.onSelectedDateChangedRange,
                  firstDate: controllerStatusScreen.firstDate,
                  lastDate: controllerStatusScreen.lastDate,
                  datePickerStyles: DatePickerRangeStyles(
                      selectedSingleDateDecoration: BoxDecoration(
                          color: bluePrimary, shape: BoxShape.circle),
                      selectedPeriodMiddleDecoration: BoxDecoration(
                          color: Colors.blue.shade500.withOpacity(0.5)),
                      selectedPeriodStartDecoration: BoxDecoration(
                          color: bluePrimary,
                          borderRadius: BorderRadius.only(
                              topLeft: roundedMedium,
                              bottomLeft: roundedMedium)),
                      selectedPeriodLastDecoration: BoxDecoration(
                          color: bluePrimary,
                          borderRadius: BorderRadius.only(
                              topRight: roundedMedium,
                              bottomRight: roundedMedium))),
                )),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text(
                'OK',
                style: semiBoldStyle.copyWith(color: bluePrimary),
              ),
            ),
          ],
        );
      },
    );
  }
}
