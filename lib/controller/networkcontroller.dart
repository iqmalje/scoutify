import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NetworkController extends GetxController {
  final InternetConnectionCheckerPlus _connection =
      InternetConnectionCheckerPlus();
  bool hasConnection = true;

  @override
  void onInit() {
    super.onInit();
    _connection.onStatusChange.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(InternetConnectionStatus status) async {
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
      if (Supabase.instance.client.auth.currentUser != null &&
          CurrentAccount.getInstance().scoutInfo == null) {
        try {
          await AccountDAO().setInstanceAccount();
        } catch (e) {}
      }
      hasConnection = true;
      if (Get.isSnackbarOpen) {
        try {
          Get.closeCurrentSnackbar();
        } catch (e) {}
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
