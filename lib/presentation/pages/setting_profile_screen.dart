import 'package:apllication_book_now/presentation/state_management/controller_profile.dart';
import 'package:apllication_book_now/presentation/widgets/header.dart';
import 'package:apllication_book_now/presentation/widgets/list_button.dart';
import 'package:apllication_book_now/presentation/widgets/loading_data.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../state_management/controller_login.dart';
import '../widgets/list_textfield.dart';

class SettingProfileScreen extends StatelessWidget {
  SettingProfileScreen({super.key});

  final controllerLogin = Get.find<ControllerLogin>();
  final ControllerProfile controllerProfile = Get.put(ControllerProfile());

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _noTelpon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerWithIcon("Ubah Profile"),
      body: _buildPageProfileScreen(context),
    );
  }

  SafeArea _buildPageProfileScreen(BuildContext context) {
    _nama.text = controllerLogin.user.value!.namaPembeli;
    _noTelpon.text = controllerLogin.user.value!.phoneNumber;
    return SafeArea(
        child: Padding(
      padding: sidePaddingBig,
      child: Column(
        children: [
          spaceHeightBig,
          textFieldInput("Nama Lengkap", "Nama Lengkap", _nama, context,
              typeInput: TextInputType.name, formatter: []),
          textFieldInput("No Telepon", "No Telepon", _noTelpon, context,
              typeInput: TextInputType.phone,
              lenght: 13,
              formatter: [FilteringTextInputFormatter.digitsOnly]),
          Expanded(child: Container()),
          Obx(() {
            if (controllerProfile.isLoading.value) {
              return loadingData("mengubah data..");
            } else {
              return buttonPrimary("Simpan", () {
                String nama = _nama.text;
                String telp = _noTelpon.text;
                String idUser = controllerLogin.user.value!.idUsers.toString();

                bool checkField =
                    controllerProfile.checkDataProfile(nama, telp);
                if (!checkField) {
                  controllerProfile.updateDataUser(idUser, nama, telp);
                }
              });
            }
          }),
          spaceHeightBig
        ],
      ),
    ));
  }
}
