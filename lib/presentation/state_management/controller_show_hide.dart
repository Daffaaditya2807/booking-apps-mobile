import 'package:get/get.dart';

class ShowHidePassword extends GetxController {
  var isShow = true.obs;
  var isShowConfirm = true.obs;
  var isPasswordOld = true.obs;

  void showHidePassword() {
    isShow.value = !isShow.value;
  }

  void showHideConfirmPassword() {
    isShowConfirm.value = !isShowConfirm.value;
  }

  void showHideOldPassword() {
    isPasswordOld.value = !isPasswordOld.value;
  }
}
