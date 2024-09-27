import 'package:apllication_book_now/config/routes/routes.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Book Now',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: bluePrimary),
          useMaterial3: true,
        ),
        initialRoute: Routes.initalRoutes,
        getPages: Routes.routesList);
  }
}
