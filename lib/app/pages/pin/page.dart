import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/pages/pin/widget/pin_page_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    switch (controller.pinPageType) {
      case PinPageType.unlock:
        return const UnlockPinPage();
      case PinPageType.onboarding:
        return const OnboardingPinPage();
      default:
        return const UnlockPinPage();
    }
  }
}

class OnboardingPinPage extends GetView<PinPageController> {
  const OnboardingPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PinPageBase(
        headerText: '로그인을 완료하기 위해\n핀을 입력해주세요',
        onPinComplete: controller.onboardingAuth,
        pinCouont: controller.pinCount,
      ),
    );
  }
}

class UnlockPinPage extends GetView<PinPageController> {
  const UnlockPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PinPageBase(
        headerText: '핀을 입력해\n잠금을 해제하세요',
        onPinComplete: controller.validatePin,
        pinCouont: controller.pinCount,
      ),
    );
  }
}
