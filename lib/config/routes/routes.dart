import 'package:apllication_book_now/presentation/pages/introduction_first_screen.dart';
import 'package:apllication_book_now/presentation/pages/introduction_last_screen.dart';
import 'package:apllication_book_now/presentation/pages/login_screen.dart';
import 'package:apllication_book_now/presentation/pages/register_screen.dart';
import 'package:apllication_book_now/presentation/pages/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String splashScreen = "/splashScreen";
  static String introductionFirst = "/introductionFirst";
  static String introductionLast = "/introductionLast";
  static String loginScreen = "/loginScreen";
  static String registerScreen = "/registerScreen";

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
  ];
  // static Map<String, Widget Function(BuildContext)> routesList = {
  //   splashScreen: (context) => const SplashScreen(),
  //   introductionFirst: (context) => const IntroductionFirst(),
  //   introductionLast: (context) => const IntroductionLastScreen(),
  //   loginScreen: (context) => LoginScreen(),
  //   registerScreen: (context) => RegisterScreen()
  // };
}
