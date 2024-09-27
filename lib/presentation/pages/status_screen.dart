import 'package:apllication_book_now/presentation/state_management/controller_status_screen.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
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

  List<Tab> menuTab = [
    const Tab(
      text: "Dipesan",
    ),
    const Tab(
      text: "Diproses",
    ),
    const Tab(
      text: "Ditolak",
    ),
    const Tab(
      text: "Selesai",
    )
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 4);
    controllerStatusScreen
        .assignAllHistoryPesan(controllerUser.user.value!.idUsers.toString());
    controllerStatusScreen
        .assignAllHistoryProses(controllerUser.user.value!.idUsers.toString());
    controllerStatusScreen
        .assignHistoryDitolak(controllerUser.user.value!.idUsers.toString());
    controllerStatusScreen
        .assignHistorySelesai(controllerUser.user.value!.idUsers.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesTest = [
      Obx(() {
        if (controllerStatusScreen.isLoading.value) {
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
                  itemBuilder: (context, index) {
                    final historyPesann =
                        controllerStatusScreen.historyPesan[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historyPesann);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: serviceCard(
                            context,
                            historyPesann.layanan.name,
                            historyPesann.layanan.description,
                            historyPesann.layanan.image),
                      ),
                    );
                  },
                );
        }
      }),
      Obx(() {
        if (controllerStatusScreen.isLoading.value) {
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
                  itemBuilder: (context, index) {
                    final historyProses =
                        controllerStatusScreen.historyProses[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historyProses);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: serviceCard(
                            context,
                            historyProses.layanan.name,
                            historyProses.layanan.description,
                            historyProses.layanan.image),
                      ),
                    );
                  },
                );
        }
      }),
      Obx(() {
        if (controllerStatusScreen.isLoading.value) {
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
                  itemBuilder: (context, index) {
                    final historyTolak =
                        controllerStatusScreen.historyTolak[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historyTolak);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: serviceCard(
                            context,
                            historyTolak.layanan.name,
                            historyTolak.layanan.description,
                            historyTolak.layanan.image),
                      ),
                    );
                  },
                );
        }
      }),
      Obx(() {
        if (controllerStatusScreen.isLoading.value) {
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
                  itemBuilder: (context, index) {
                    final historySelesai =
                        controllerStatusScreen.historySelesai[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.serviceStatusScreen,
                            arguments: historySelesai);
                      },
                      child: Padding(
                        padding: sidePaddingBig,
                        child: serviceCard(
                            context,
                            historySelesai.layanan.name,
                            historySelesai.layanan.description,
                            historySelesai.layanan.image),
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
