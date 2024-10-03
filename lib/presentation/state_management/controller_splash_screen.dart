import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/presentation/state_management/controller_login.dart';
import 'package:get/get.dart';

class ControllerSplashScreen extends GetxController {
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    navigateSplashScreen();
    controllerLogin.loadUserFromPrefs();
  }

  Future<void> navigateSplashScreen() async {
    // Wait for the splash screen duration
    await Future.delayed(const Duration(milliseconds: 2000));

    // Check if the user is logged in
    if (controllerLogin.user.value != null) {
      Get.offNamed(
          Routes.navbarMenu); // Navigate to Dashboard if user is logged in
    } else {
      Get.offNamed(Routes
          .introductionFirst); // Navigate to Introduction Screen if not logged in
    }
  }
}
