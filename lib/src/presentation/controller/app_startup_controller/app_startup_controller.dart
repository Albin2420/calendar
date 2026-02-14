import 'dart:developer';

import 'package:calendar/src/presentation/screens/Home/home_screen.dart';
import 'package:get/get.dart';

class AppStartupController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  Future<void> navigate() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => HomeScreen());
    } catch (e) {
      log("💥 expection in navigation():$e");
    }
  }
}
