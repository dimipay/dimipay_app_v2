import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';

class DPSnackBar {
  static void open(String title, {Color backgroundColor = DPColors.primaryBrand, Color textColor = Colors.white}) {
    Get.rawSnackbar(
      titleText: Text(title, style: DPTypography.paragraph1().copyWith(color: Colors.white)),
      messageText: Container(),
      backgroundColor: backgroundColor,
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      animationDuration: const Duration(milliseconds: 800),
    );
  }
}

class DPErrorSnackBar {
  void open(String title, {String? message}) {
    DPSnackBar.open(title, backgroundColor: DPColors.primaryNegative, textColor: Colors.white);
  }
}
