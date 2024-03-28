import 'package:get/get.dart';

import 'controller/networkcontroller.dart';

class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}