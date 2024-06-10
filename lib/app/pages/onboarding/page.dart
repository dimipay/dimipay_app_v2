import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/pages/manual.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/pages/suggest_card_registratoin.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/pages/suggest_facesign_registration.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/pages/terms_agreement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends GetView<OnboardingPageController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingPageController>(
      init: OnboardingPageController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentPageIndex.value = index;
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SuggestCardRegistratoinPage(controller: controller),
                SuggestFaceSignRegistratoinPage(controller: controller),
                TermsAgreementPage(controller: controller),
                ManualPage(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}
