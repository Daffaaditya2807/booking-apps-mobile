import 'package:apllication_book_now/presentation/pages/booking_done_screen.dart';
import 'package:apllication_book_now/presentation/pages/booking_screen.dart';
import 'package:apllication_book_now/presentation/pages/detail_service_screen.dart';
import 'package:apllication_book_now/presentation/pages/introduction_first_screen.dart';
import 'package:apllication_book_now/presentation/pages/introduction_last_screen.dart';
import 'package:apllication_book_now/presentation/pages/login_screen.dart';
import 'package:apllication_book_now/presentation/pages/main_menu.dart';
import 'package:apllication_book_now/presentation/pages/register_screen.dart';
import 'package:apllication_book_now/presentation/pages/setting_password_screen.dart';
import 'package:apllication_book_now/presentation/pages/setting_profile_screen.dart';
import 'package:apllication_book_now/presentation/pages/setting_screen.dart';
import 'package:apllication_book_now/presentation/pages/splash_screen.dart';
import 'package:apllication_book_now/presentation/pages/status_service_screen.dart';
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

  static String initalRoutes = splashScreen;
  static final List<GetPage> routesList = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: introductionFirst,
      page: () => const IntroductionFirst(),
    ),
    GetPage(
      name: introductionLast,
      page: () => const IntroductionLastScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: navbarMenu,
      page: () => MainMenu(),
    ),
    GetPage(name: settingScreen, page: () => SettingScreen()),
    GetPage(name: detailServiceScreen, page: () => const DetailServiceScreen()),
    GetPage(name: bookingScreen, page: () => BookingScreen()),
    GetPage(name: bookingDoneScreen, page: () => const BookingDoneScreen()),
    GetPage(name: serviceStatusScreen, page: () => const StatusServiceScreen()),
    GetPage(name: profileSettingScreen, page: () => SettingProfileScreen()),
    GetPage(name: passwordSettingScreen, page: () => SettingPasswordScreen())
  ];
  // static Map<String, Widget Function(BuildContext)> routesList = {
  //   splashScreen: (context) => const SplashScreen(),
  //   introductionFirst: (context) => const IntroductionFirst(),
  //   introductionLast: (context) => const IntroductionLastScreen(),
  //   loginScreen: (context) => LoginScreen(),
  //   registerScreen: (context) => RegisterScreen()
  // };
}
