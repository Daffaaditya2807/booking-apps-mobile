import 'dart:async';
import 'package:apllication_book_now/presentation/widgets/snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerConnection extends GetxController {
  // Ubah tipe subscription sesuai dengan tipe yang diharapkan
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  var isConnected = true.obs;

  void listenConnectivity(
      {VoidCallback? onDisconnected, VoidCallback? onConnected}) {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      for (var result in results) {
        isConnected.value = result != ConnectivityResult.none;
        print('koneksi $result output ${isConnected.value}');
        if (result == ConnectivityResult.none) {
          print("Koneksi kosong");
          snackBarError(
              "Koneksi Internet Terputus", "Harap nyalakan koneksi internet");
          if (onDisconnected != null) {
            onDisconnected();
          }
          break;
        } else {
          if (onConnected != null) {
            print("ON CONNECTED DIJALANKAN");
            onConnected();
          }
          break;
        }
      }
    });
  }
}
