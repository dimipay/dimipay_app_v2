import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestCardRegistratoinPage extends StatelessWidget {
  final OnboardingPageController controller;
  const SuggestCardRegistratoinPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Column(
      children: [
        const DPAppbar(header: '카드를 등록할까요?'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '앱에 카드를 등록해야 결제 키오스크에서 결제를 진행할 수 있어요.',
                      style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.nextPage();
                },
                child: Text('나중에 할래요', style: textTheme.paragraph2Underlined.copyWith(color: colorTheme.grayscale600)),
              ),
              const SizedBox(height: 16),
              DPButton(
                onTap: () async {
                  bool result = await Get.toNamed(Routes.REGISTER_CARD);
                  if (result) {
                    controller.nextPage();
                  }
                },
                child: const Text('등록할래요'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
