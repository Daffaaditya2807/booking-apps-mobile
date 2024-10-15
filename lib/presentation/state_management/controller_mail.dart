import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/api.dart';
import 'package:apllication_book_now/data/data_sources/email_template.dart';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

class ControllerMail extends GetxController {
  var emailVerificationCode = 0.obs;
  var isLoading = false.obs;
  var isLoadingVerified = false.obs;
  var isLoadingSendAgain = false.obs;
  var candSendEmail = false.obs;
  final Random random = Random();
  var countdown = 60.obs;

  // int makeCodeOtp() {
  //   return emailVerificationCode.value = 000000 + random.nextInt(900000);
  // }
  int makeCodeOtp() {
    int otp =
        random.nextInt(900000) + 100000; // Pastikan angkanya memiliki 6 digit
    return emailVerificationCode.value =
        int.parse(otp.toString().padLeft(6, '0'));
  }

  void startTimer() {
    try {
      Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (countdown.value == 0) {
          timer.cancel();
          candSendEmail(true);
        } else {
          countdown.value--;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendEmail(
      BuildContext context, String email, String name) async {
    String username = 'antriquapps@gmail.com';
    String password = 'kgts qgce vszl umkk';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Antriqu Apps')
      ..recipients.add(email)
      ..subject = 'KODE OTP VERIFICATION'
      ..html = emailTemplate(name, emailVerificationCode.toString());

    isLoading(true);
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      if (countdown.value == 0) {
        countdown.value = 60;
        candSendEmail(false);
        startTimer();
      }
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifiedUser(String idUser) async {
    isLoadingVerified(true);
    try {
      String url = '${apiService}verified';
      final response = await http.post(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({'id_users': idUser}));
      final responseBody = json.decode(response.body);

      int code = responseBody['meta']['code'];

      if (code == 200) {
        Get.offAllNamed(Routes.loginScreen);
      } else if (code == 500) {
        snackBarError("Gagal verified User", "Ada sesuatu yang error");
      }
    } catch (e) {
      snackBarError("Error", e.toString());
    } finally {
      isLoadingVerified(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    makeCodeOtp();
    startTimer();
    print(makeCodeOtp().toString());
  }
}
