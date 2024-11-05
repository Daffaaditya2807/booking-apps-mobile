import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/data/data_sources/notification_helper.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:timezone/data/latest.dart' as tz;

void main() async {
  await initializeDateFormatting('id');
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  NotificationHelper().initializeAppMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Book Now',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('id', 'ID')],
        locale: const Locale('id', 'ID'),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: bluePrimary),
          useMaterial3: true,
        ),
        initialRoute: Routes.initalRoutes,
        getPages: Routes.routesList);
  }
}
