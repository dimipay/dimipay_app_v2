import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPSnackBar {
  static void open(String title, {Color? borderColor, Color? textColor}) {
    BuildContext context = Get.context!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    HapticHelper.feedback(HapticPatterns.success, hapticType: HapticType.heavy);

    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.rawSnackbar(
      titleText: Center(
        child: Text(
          title,
          style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale900),
          textAlign: TextAlign.center,
        ),
      ),
      icon: Icon(
        Icons.info_outline_rounded,
        color: borderColor ?? colorTheme.primaryBrand,
      ),
      messageText: Container(),
      backgroundColor: colorTheme.grayscale100,
      borderColor: borderColor ?? colorTheme.primaryBrand,
      borderRadius: 9999,
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}

class DPErrorSnackBar {
  void open(String title, {String? message, bool haptic = true}) {
    BuildContext context = Get.context!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    HapticHelper.feedback(HapticPatterns.error, hapticType: HapticType.vibrate);
    DPSnackBar.open(title, borderColor: colorTheme.primaryNegative);
    HapticHelper.feedback(HapticPatterns.error);
  }
}
