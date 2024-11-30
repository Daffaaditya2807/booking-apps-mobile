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
import 'package:badges/badges.dart' as badges;

import '../../config/routes/routes.dart';
import '../../data/data_sources/api.dart';
import '../state_management/controller_login.dart';
import '../state_management/controller_status_lewati.dart';
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
  final statusLewatiController = Get.put(ControllerStatusLewati());
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
              : ListView.separated(
                  itemCount: controllerStatusScreen.historyPesan.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Padding(
                    padding: sidePaddingBig,
                    child: Divider(
                      color: greyTersier,
                    ),
                  ),
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
              : ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: sidePaddingBig,
                    child: Divider(
                      color: greyTersier,
                    ),
                  ),
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
              : ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: sidePaddingBig,
                    child: Divider(
                      color: greyTersier,
                    ),
                  ),
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
              : ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: sidePaddingBig,
                    child: Divider(
                      color: greyTersier,
                    ),
                  ),
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
      appBar: headerWithTabBars(
        "Status",
        controller!,
        menuTab,
        useBadges: true,
        onTapBadges: () {
          Get.toNamed(Routes.statusLewatiScreen);
        },
      ),
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

                                          controllerStatusScreen
                                                  .valueDateFilter.value =
                                              controllerStatusScreen
                                                  .convMonthYear(
                                                      controllerStatusScreen
                                                          .selectedDate.value
                                                          .toString());
                                          showMonthPicker(context);
                                          controller.update;
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
                                        controllerStatusScreen
                                                .valueDateFilter.value =
                                            "${controllerStatusScreen.convDate(controllerStatusScreen.selectedPeriod.value.start.toString())} - ${controllerStatusScreen.convDate(controllerStatusScreen.selectedPeriod.value.end.toString())}";
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
                                            style: regularStyle.copyWith(
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

  AppBar headerWithTabBars(
      String label, TabController controller, List<Tab> menuTabBar,
      {bool? useBadges = false, VoidCallback? onTapBadges}) {
    statusLewatiController.listenToUnreadNotifications(
        controllerUser.user.value!.idUsers.toString());
    return AppBar(
      title: Text(
        label,
        style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth4),
      ),
      centerTitle: true,
      actions: [
        useBadges == true
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: badges.Badge(
                  badgeContent: Obx(() => Text(
                        "${statusLewatiController.unreadCount}",
                        style: semiBoldStyle.copyWith(
                          color: Colors.white,
                          fontSize: smallFont,
                        ),
                      )),
                  position: badges.BadgePosition.topEnd(top: 4, end: 9),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor: Colors.blue,
                    padding: EdgeInsets.all(5),
                    elevation: 0,
                  ),
                  child: IconButton(
                      onPressed: () {
                        statusLewatiController.markNotificationsAsRead(
                            controllerUser.user.value!.idUsers.toString());
                        onTapBadges?.call();
                      },
                      icon: const Icon(Icons.notifications)),
                ),
              )
            : Container()
      ],
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
              controller: controller,
              labelStyle: semiBoldStyle.copyWith(
                  color: blueSecondary, fontSize: regularFont),
              labelColor: blueSecondary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              unselectedLabelColor: greySecondary,
              indicatorColor: Colors.amber,
              tabs: menuTabBar)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
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
            miniButtonPrimary("OK", () => Navigator.of(context).pop()),
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
                      nextIcon: Container(
                        decoration: BoxDecoration(
                            color: yellowActive,
                            borderRadius: roundedMediumGeo),
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
                            color: yellowActive,
                            borderRadius: roundedMediumGeo),
                        child: const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.chevron_left,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      selectedSingleDateDecoration: BoxDecoration(
                          color: yellowActive, shape: BoxShape.circle),
                      selectedPeriodMiddleDecoration: BoxDecoration(
                          color: Colors.amberAccent.withOpacity(0.5)),
                      selectedPeriodMiddleTextStyle:
                          semiBoldStyle.copyWith(color: Colors.white),
                      selectedPeriodStartDecoration: BoxDecoration(
                          color: yellowActive,
                          borderRadius: BorderRadius.only(
                              topLeft: roundedMedium,
                              bottomLeft: roundedMedium)),
                      selectedPeriodStartTextStyle:
                          boldStyle.copyWith(color: Colors.white),
                      selectedPeriodLastDecoration: BoxDecoration(
                          color: yellowActive,
                          borderRadius: BorderRadius.only(
                              topRight: roundedMedium,
                              bottomRight: roundedMedium)),
                      selectedPeriodEndTextStyle:
                          boldStyle.copyWith(color: Colors.white)),
                )),
          ),
          actions: [
            miniButtonPrimary("OK", () => Navigator.of(context).pop()),
          ],
        );
      },
    );
  }
}
