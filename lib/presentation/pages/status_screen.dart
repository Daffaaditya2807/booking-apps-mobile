import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

import '../widgets/information.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
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
    Column(
      children: [
        Expanded(child: Container()),
        informationTextAsset(
            "assets/image/splash_screen/empty1.png",
            "Booking Kosong!",
            "Belum ada layanan yang anda pesan. Pesan sekarang dan nikmati layanan terbaik kami sekarang juga!"),
        Expanded(child: Container()),
      ],
    ),
    const Icon(Icons.list),
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
      backgroundColor: Colors.white,
      appBar: headerWithTabBar("Status", controller!, menuTab),
      body: bodyTabBar(pagesTest, controller!),
    );
  }
}
