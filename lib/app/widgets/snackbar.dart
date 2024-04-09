import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPSnackBar {
  static void open(String title, {Color? backgroundColor, Color? textColor}) {
    BuildContext context = Get.context!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    HapticHelper.feedback(HapticPatterns.success, hapticType: HapticType.heavy);
    Get.rawSnackbar(
      titleText: Text(title, style: textTheme.paragraph1.copyWith(color: textColor ?? Colors.white)),
      messageText: Container(),
      backgroundColor: backgroundColor ?? colorTheme.primaryBrand,
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      animationDuration: const Duration(milliseconds: 800),
    );
  }
}

class DPErrorSnackBar {
  void open(String title, {String? message}) {
    BuildContext context = Get.context!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    HapticHelper.feedback(HapticPatterns.error, hapticType: HapticType.vibrate);
    DPSnackBar.open(title, backgroundColor: colorTheme.primaryNegative, textColor: Colors.white);
  }
}
