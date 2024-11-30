import 'package:apllication_book_now/presentation/pages/booking_done_screen.dart';
import 'package:apllication_book_now/presentation/pages/booking_screen.dart';
import 'package:apllication_book_now/presentation/pages/detail_service_screen.dart';
import 'package:apllication_book_now/presentation/pages/forget_password_screen.dart';
import 'package:apllication_book_now/presentation/pages/introduction_first_screen.dart';
import 'package:apllication_book_now/presentation/pages/introduction_last_screen.dart';
import 'package:apllication_book_now/presentation/pages/login_screen.dart';
import 'package:apllication_book_now/presentation/pages/main_menu.dart';
import 'package:apllication_book_now/presentation/pages/otp_screen.dart';
import 'package:apllication_book_now/presentation/pages/register_screen.dart';
import 'package:apllication_book_now/presentation/pages/reset_password_screen.dart';
import 'package:apllication_book_now/presentation/pages/setting_password_screen.dart';
import 'package:apllication_book_now/presentation/pages/setting_profile_screen.dart';
import 'package:apllication_book_now/presentation/pages/setting_screen.dart';
import 'package:apllication_book_now/presentation/pages/splash_screen.dart';
import 'package:apllication_book_now/presentation/pages/status_lewati_screen.dart';
import 'package:apllication_book_now/presentation/pages/status_screen.dart';
import 'package:apllication_book_now/presentation/pages/status_service_screen.dart';
import 'package:apllication_book_now/presentation/pages/update_status_done_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static String splashScreen = "/splashScreen";
  static String introductionFirst = "/introductionFirst";
  static String introductionLast = "/introductionLast";
  static String loginScreen = "/loginScreen";
  static String registerScreen = "/registerScreen";
  static String navbarMenu = "/navbarmenu";
  static String settingScreen = "/settingScreen";
  static String detailServiceScreen = "/detailServiceScreen";
  static String bookingScreen = "/bookingScreen";
  static String bookingDoneScreen = "/bookingDoneScreen";
  static String serviceStatusScreen = "/statusSericeScreen";
  static String profileSettingScreen = "/profileSettingScreen";
  static String passwordSettingScreen = "/passwordSettingScreen";
  static String statusScreen = "/statusScreen";
  static String doneUpdateStatusScreen = '/doneUpdateStatusScreen';
  static String otpInputScreen = '/otpScreen';
  static String resetPasswordScreen = '/resetPasswordScreen';
  static String forgetPasswordScreen = '/forgetPasswordScreen';
  static String statusLewatiScreen = '/statusLewatiScreen';

  static String initalRoutes = splashScreen;
  static final List<GetPage> routesList = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: introductionFirst,
      transition: Transition.cupertino,
      curve: Curves.linear,
      transitionDuration: const Duration(milliseconds: 1500),
      page: () => const IntroductionFirst(),
    ),
    GetPage(
      name: introductionLast,
      transition: Transition.cupertino,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const IntroductionLastScreen(),
    ),
    GetPage(
      name: loginScreen,
      transition: Transition.cupertino,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => LoginScreen(),
    ),
    GetPage(
      name: registerScreen,
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: navbarMenu,
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => MainMenu(),
    ),
    GetPage(
        name: settingScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => SettingScreen()),
    GetPage(
        name: detailServiceScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => const DetailServiceScreen()),
    GetPage(
        name: bookingScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => BookingScreen()),
    GetPage(
        name: bookingDoneScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => BookingDoneScreen()),
    GetPage(
        name: serviceStatusScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => StatusServiceScreen()),
    GetPage(
        name: profileSettingScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => SettingProfileScreen()),
    GetPage(
      name: passwordSettingScreen,
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => SettingPasswordScreen(),
    ),
    GetPage(
        name: statusScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => const StatusScreen()),
    GetPage(
        name: doneUpdateStatusScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => const ScreenUpdateStatusDone()),
    GetPage(
        name: otpInputScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => OtpScreen()),
    GetPage(
        name: forgetPasswordScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => ForgetPasswordScreen()),
    GetPage(
        name: resetPasswordScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => ResetPasswordScreen()),
    GetPage(
        name: statusLewatiScreen,
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => StatusLewatiScreen())
  ];
}
