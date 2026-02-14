import 'package:calendar/src/presentation/controller/app_startup_controller/app_startup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppStartupController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(child: Image.asset(scale: 3, "assets/icons/logo.png")),
      ),
    );
  }
}
