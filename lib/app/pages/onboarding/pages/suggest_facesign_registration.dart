import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestFaceSignRegistratoinPage extends StatelessWidget {
  final OnboardingPageController controller;
  const SuggestFaceSignRegistratoinPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Column(
      children: [
        const DPAppbar(header: 'FaceSign을 등록할까요?'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'FaceSign을 등록하면 키오스크에서 디미페이 앱 없이 FaceSign으로 간편하게 결제할 수 있어요.',
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
              DPButton(
                isTapEffectEnabled: false,
                onTap: () {
                  controller.nextPage();
                },
                child: Text('나중에 할래요', style: textTheme.paragraph2Underlined.copyWith(color: colorTheme.grayscale600)),
              ),
              const SizedBox(height: 16),
              DPButton(
                decoration: BoxDecoration(
                  color: colorTheme.primaryBrand,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(BorderSide(
                    color: colorTheme.primaryBrand,
                    width: 1,
                  )),
                ),
                isTapEffectEnabled: true,
                radius: const BorderRadius.all(Radius.circular(10)),
                onTap: () async {
                  bool result = await Get.toNamed(Routes.FACESIGN);
                  if (result) {
                    controller.nextPage();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('등록할래요', style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale1000)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
