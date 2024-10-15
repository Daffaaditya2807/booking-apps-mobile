import 'package:apllication_book_now/presentation/state_management/controller_get_service.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_service.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/routes.dart';
import '../../data/data_sources/api.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({super.key});

  final ControllerGetService controllerGetService =
      Get.put(ControllerGetService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header("Layanan"),
      body: RefreshIndicator(
          onRefresh: () async {
            controllerGetService.fetchService();
          },
          child: _buildPageServiceScreen()),
    );
  }

  SafeArea _buildPageServiceScreen() {
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Obx(() {
        if (controllerGetService.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controllerGetService.serviceList.length,
            itemBuilder: (context, index) {
              final service = controllerGetService.serviceList[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.bookingScreen, arguments: service);
                },
                child: serviceCard(context, service.name, service.description,
                    '$apiImage${service.image}'),
              );
            },
          );
        }
      }),
    ));
  }
}
