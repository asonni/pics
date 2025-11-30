import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbars {
  static void errorSnackbar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  static void successSnackbar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      shouldIconPulse: true,
      icon: Icon(Icons.info),
    );
  }

  static void infoSnackbar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  static void customSnackbar({
    required String title,
    String message = '',
    Color bgColor = Colors.red,
    Color textColor = Colors.white,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: textColor,
      snackPosition: snackPosition,
      duration: duration,
    );
  }
}
