import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/pages/pin/widget/pin_page_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (controller.pinPageType) {
            case PinPageType.unlock:
              return const UnlockPinPage();
            case PinPageType.onboarding:
              return const OnboardingPinPage();
            case PinPageType.editPin:
              return const EditPinPage();
            default:
              return const UnlockPinPage();
          }
        },
      ),
    );
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
        faceIDAvailable: true,
      ),
    );
  }
}

class EditPinPage extends GetView<PinPageController> {
  const EditPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.status) {
          case PinPageStatus.preCheck:
            return PinPageBase(
              headerText: '기존의 결제 핀을\n입력해주세요',
              onPinComplete: controller.changePinPreCheck,
              pinCouont: controller.pinCount,
            );
          case PinPageStatus.nomal:
            return PinPageBase(
              headerText: '앞으로 사용할\n새 결제 핀을 입력해주세요',
              onPinComplete: controller.changePinNomal,
              pinCouont: controller.pinCount,
            );
          case PinPageStatus.doubleCheck:
            return PinPageBase(
              headerText: '앞으로 사용할\n결제 핀을 다시 입력해주세요',
              onPinComplete: controller.changePinDoubleCheck,
              pinCouont: controller.pinCount,
            );
        }
      },
    );
  }
}
