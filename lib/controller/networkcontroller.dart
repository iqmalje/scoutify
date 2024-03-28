import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkController extends GetxController {
  final InternetConnectionCheckerPlus _connection =
      InternetConnectionCheckerPlus();
  bool hasConnection = true;

  @override
  void onInit() {
    super.onInit();
    _connection.onStatusChange.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(InternetConnectionStatus status) {
    if (status == InternetConnectionStatus.disconnected) {
      hasConnection = false;
      Get.rawSnackbar(
          messageText: const Text('Please connect to the Internet',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
      debugPrint("No Connection");
    } else {
      hasConnection = true;
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  bool checkInternetConnectivity() {
    return hasConnection;
  }

  void setInternetConnectivity(bool connection) {
    hasConnection = connection;
  }
}
