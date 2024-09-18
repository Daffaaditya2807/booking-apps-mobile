import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:get/get.dart';

class ControllerSplashScreen extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    navigateSplashScreen();
  }

  Future<void> navigateSplashScreen() async {
    Future.delayed(const Duration(milliseconds: 2000),
        () => Get.offNamed(Routes.introductionFirst));
  }
}
