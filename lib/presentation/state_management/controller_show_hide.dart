import 'package:get/get.dart';

class ShowHidePassword extends GetxController {
  var isShow = true.obs;

  void showHidePassword() {
    isShow.value = !isShow.value;
  }
}
