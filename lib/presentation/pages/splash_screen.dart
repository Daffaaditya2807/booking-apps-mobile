import 'package:apllication_book_now/presentation/state_management/controller_splash_screen.dart';
import 'package:apllication_book_now/presentation/widgets/no_internet.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../resource/sizes/list_margin.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final ControllerSplashScreen controllerSplashScreen =
      Get.put(ControllerSplashScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() =>
          controllerSplashScreen.controllerConnection.isConnected.value
              ? _buildPageSplashScreen(context)
              : noInternetConnection()),
    );
  }

  Widget _buildPageSplashScreen(BuildContext context) {
    double heightAppBar = MediaQuery.of(context).viewPadding.top;
    double heightScreen = MediaQuery.sizeOf(context).height;
    double heightContainer =
        (heightScreen - kToolbarHeight - heightAppBar) * 0.25;

    return Obx(() {
      if (controllerSplashScreen.profileModel.value == null) {
        return Container();
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
            ),
            CachedNetworkImage(
              imageUrl: controllerSplashScreen.profileModel.value!.logo,
              fit: BoxFit.cover,
              width: heightContainer,
              height: heightContainer,
              placeholder: (context, url) => Placeholder(
                color: greyTersier,
                strokeWidth: 1.0,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            spaceHeightBig,
            Text(controllerSplashScreen.profileModel.value?.namaUsaha ?? '',
                    style: boldStyle.copyWith(
                        color: bluePrimary, fontSize: fonth2))
                .animate()
                .shader(
                  duration: const Duration(milliseconds: 2000),
                )
                .fadeIn(duration: 300.ms)
                .slide(),
          ],
        );
      }
    });
  }
}
