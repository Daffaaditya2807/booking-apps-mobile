import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';

import '../widgets/list_service.dart';

class StatusServiceScreen extends StatelessWidget {
  const StatusServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerWithIcon("Status Antrian"),
      body: SafeArea(
          child: Padding(
        padding: sidePaddingBig,
        child: Column(
          children: [
            spaceHeightBig,
            detailStatusService(context, "ddd", "sss")
          ],
        ),
      )),
    );
  }
}
