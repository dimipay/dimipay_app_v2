import 'package:dimipay_app_v2/app/pages/onboarding_pin/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPinPage extends GetView<OnboardingPageController> {
  const OnboardingPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OnboardingPinPage')),
      body: Column(
        children: [
          TextField(
            onSubmitted: (value) => controller.onboardingAuth(value),
          )
        ],
      ),
    );
  }
}
