import 'package:apllication_book_now/presentation/state_management/controller_mail.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../config/routes/routes.dart';
import '../widgets/list_text.dart';
import '../widgets/otp_widget.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ControllerMail controllerMail = Get.put(ControllerMail());
  TextEditingController controllerOtp = TextEditingController();

  final String email = Get.arguments['email'];
  final String name = Get.arguments['name'];
  final String idUser = Get.arguments['id_user'];
  final String page = Get.arguments['page'];

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerMail.sendEmail(context, email, name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: sidePaddingBig,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              componenTextHeaderDescCenter(
                  "OTP", "Silakan masukkan kode OTP dari email"),
              spaceHeightMedium,
              Text(
                email,
                style: semiBoldStyle.copyWith(color: Colors.black),
              ),
              spaceHeightBig,
              Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  controller: controllerOtp,
                  submittedPinTheme: submittedPinTheme,
                  validator: (s) {
                    return s ==
                            controllerMail.emailVerificationCode.value
                                .toString()
                        ? null
                        : 'Pin Tidak sama';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  length: 6,
                  onCompleted: (value) {
                    if (controllerMail.emailVerificationCode.toString() ==
                        controllerOtp.text) {
                      if (page == 'register') {
                        controllerMail.verifiedUser(idUser);
                      } else {
                        Get.offNamed(Routes.resetPasswordScreen,
                            arguments: {"email": email});
                      }
                    }
                  }),
              spaceHeightBig,
              Obx(() {
                if (controllerMail.isLoadingVerified.value) {
                  return loadingData("verifikasi user");
                } else {
                  return Container();
                }
              }),
              Divider(
                color: greyTersier,
              ),
              InkWell(
                onTap: () {},
                child: Obx(() => controllerMail.isLoadingSendAgain.value
                    ? loadingData("kirim ulang code OTP")
                    : Text(
                        "Kirim ulang code OTP dalam ${controllerMail.countdown.value} detik ")),
              ),
              spaceHeightBig,
              Obx(() {
                if (controllerMail.candSendEmail.value) {
                  return controllerMail.isLoading.value
                      ? loadingData("kirim Ulang Code")
                      : buttonPrimary("Kirim Ulang Code", () {
                          if (controllerMail.candSendEmail.value) {
                            controllerMail.sendEmail(context, email, name);
                          } else {}
                        });
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
