import 'dart:async';

import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/pages/pin/widget/pin_pad.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPageBase extends GetView<PinPageController> {
  final String headerText;
  final int? pinCouont;
  final String? helpText;
  final bool faceIDAvailable;
  final FutureOr<void> Function()? onPinComplete;
  const PinPageBase({
    super.key,
    required this.headerText,
    this.pinCouont,
    this.helpText,
    this.onPinComplete,
    this.faceIDAvailable = false,
  });

  bool get locked => pinCouont != null && pinCouont! <= 0;

  Widget pinHint(bool activated, DPColors colorTheme) {
    return Container(
      width: 20,
      height: 20,
      decoration: ShapeDecoration(
        color: activated ? colorTheme.grayscale800 : colorTheme.grayscale300,
        shape: const OvalBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Container(
      color: colorTheme.grayscale100,
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            const DPAppbar(header: null),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Text(
                    locked ? '핀 시도 횟수를\n초과했습니다' : headerText,
                    style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  pinCouont == null || locked
                      ? Container(height: 26)
                      : Text(
                          '$pinCouont/5',
                          style: textTheme.header2
                              .copyWith(color: colorTheme.primaryNegative),
                        ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: prefer_is_empty
                        pinHint(controller.pin.length > 0, colorTheme),
                        const SizedBox(width: 16),
                        pinHint(controller.pin.length > 1, colorTheme),
                        const SizedBox(width: 16),
                        pinHint(controller.pin.length > 2, colorTheme),
                        const SizedBox(width: 16),
                        pinHint(controller.pin.length > 3, colorTheme),
                      ],
                    ),
                  ),
                  helpText == null
                      ? const SizedBox(height: 20)
                      : Text(
                          helpText!,
                          style: textTheme.itemDescription
                              .copyWith(color: colorTheme.grayscale500)
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
                child: Obx(
                  () => PinPad(
                    controller.nums,
                    onPinTap: (data) async {
                      controller.onPinTap.call(data);
                      if (controller.pin.length == 4) {
                        try {
                          await onPinComplete?.call();
                        } finally {
                          controller.clearPin();
                        }
                      }
                    },
                    backBtnEnabled: !locked && controller.backBtnEnabled,
                    numpadEnabled: !locked && controller.numpadEnabled,
                    faceIDAvailable: faceIDAvailable,
                    onFaceID: () => controller.authWithFaceID(),
                  ),
                ),
              ),
            const Spacer(),
            if (MediaQuery.of(context).size.height > 768)
              DPButton(
                isTapEffectEnabled: false,
                onTap: () {},
                child: Text(
                  '결제 핀을 잊어버렸어요',
                  style: textTheme.paragraph1Underlined
                      .copyWith(color: colorTheme.grayscale500),
                ),
              ),
            if (MediaQuery.of(context).size.height > 768)
              const Spacer(),
          ],
        ),
      ),
    );
  }
}
