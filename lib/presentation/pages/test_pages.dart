import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_text.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:flutter/material.dart';

import '../../resource/fonts_style/fonts_style.dart';
import '../../resource/sizes/list_font_size.dart';
import '../widgets/list_service.dart';
import '../widgets/queue_number.dart';

class TestPages extends StatelessWidget {
  const TestPages({super.key});

  @override
  Widget build(BuildContext context) {
    double heightAppBar = MediaQuery.of(context).viewPadding.top;
    double heightScreen = MediaQuery.sizeOf(context).height;
    double heightContainer =
        (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header("Pengaturan"),
      body: SafeArea(
        child: Padding(
          padding: sidePaddingBig,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeightBig,
              componentTextGreeting("Daffa Aditya"),
              spaceHeightBig,
              componentTextMenu("Ubah Profile", Icons.person, () {}),
              componentTextMenu("Ubah Password", Icons.key, () {}),
              componentTextMenu("Keluar", Icons.output_outlined, () {}),
            ],
          ),
        ),
      ),
    );
  }
}
