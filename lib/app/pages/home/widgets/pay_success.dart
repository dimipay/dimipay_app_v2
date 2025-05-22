import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaySuccessPage extends StatelessWidget {
  PaySuccessPage({super.key}) {
    HapticHelper.feedback(HapticPatterns.success, hapticType: HapticType.heavy);
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/complete.json', height: 240, repeat: false),
                  Text('성공적으로 결제되었어요', style: textTheme.token.copyWith(color: colorTheme.grayscale600)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: DPButton(
                onTap: () => Get.back(),
                child: const Text('확인'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future showSuccessDialog() async {
  BuildContext context = Get.context!;
  DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
  await showModalBottomSheet(
    context: Get.context!,
    builder: (_) => SafeArea(
      bottom: false,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: ColoredBox(
          color: colorTheme.grayscale100,
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: GetBuilder(
                init: HomePageController(),
                builder: (context) {
                  return PaySuccessPage();
                }),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: colorTheme.grayscale100,
    elevation: 0,
  );
}
