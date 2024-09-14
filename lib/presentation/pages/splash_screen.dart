import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Tab> menuTab = [
    const Tab(
      text: "Dipesan",
    ),
    const Tab(
      text: "Dipesan",
    ),
    const Tab(
      text: "Ditolak",
    ),
    const Tab(
      text: "Selesai",
    )
  ];

  List<Widget> pagesTest = [
    const Icon(Icons.abc),
    const Icon(Icons.baby_changing_station),
    const Icon(Icons.spatial_audio),
    const Icon(Icons.car_crash),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerWithTabBar("Status", controller!, menuTab),
      body: bodyTabBar(pagesTest, controller!),
    );
  }
}
