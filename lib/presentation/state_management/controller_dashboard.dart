import 'package:get/get.dart';

class ControllerDashboard extends GetxController {
  RxInt currentIndex = 0.obs;

  void getIndex(int current) {
    currentIndex.value = current;
  }
}
