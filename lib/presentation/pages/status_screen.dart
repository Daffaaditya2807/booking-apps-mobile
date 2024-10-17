import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
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
    _loadData();
    controllerStatusScreen.idUsers.value =
        controllerUser.user.value!.idUsers.toString();
  }

  void _handleTabSelection() {
    if (controller!.indexIsChanging) {
      switch (controller!.index) {
        case 0:
          controllerStatusScreen.assignAllHistoryPesan(
              controllerUser.user.value!.idUsers.toString());
          break;
        case 1:
          controllerStatusScreen.assignAllHistoryProses(
              controllerUser.user.value!.idUsers.toString());
          break;
        case 2:
          controllerStatusScreen.assignHistoryDitolak(
              controllerUser.user.value!.idUsers.toString());
          break;
        case 3:
          controllerStatusScreen.assignHistorySelesai(
              controllerUser.user.value!.idUsers.toString());
          break;
      }
    }
  }

  void _loadData() {
    print("Apakah data diload ulang");
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
      body: bodyTabBar(pagesTest, controller!),
    );
  }
}
