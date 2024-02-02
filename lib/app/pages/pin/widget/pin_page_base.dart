import 'dart:async';

import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/pages/pin/widget/pin_pad.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinPageBase extends GetView<PinPageController> {
  final String headerText;
  final int? pinCouont;
  final String? helpText;
  final FutureOr<void> Function()? onPinComplete;
  const PinPageBase({
    super.key,
    required this.headerText,
    this.pinCouont,
    this.helpText,
    this.onPinComplete,
  });

  bool get locked => pinCouont != null && pinCouont! <= 0;

  Widget pinHint(bool activated) {
    return Container(
      width: 20,
      height: 20,
      decoration: ShapeDecoration(
        color: activated ? DPColors.grayscale800 : DPColors.grayscale300,
        shape: const OvalBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Text(
                    locked ? '핀 시도 횟수를\n초과했습니다' : headerText,
                    style: DPTypography.header1(color: DPColors.grayscale1000),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  pinCouont == null || locked
                      ? Container(height: 26)
                      : Text(
                          '$pinCouont/5',
                          style: DPTypography.header2(color: DPColors.primaryNegative),
                        ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: prefer_is_empty
                        pinHint(controller.pin.length > 0),
                        const SizedBox(width: 16),
                        pinHint(controller.pin.length > 1),
                        const SizedBox(width: 16),
                        pinHint(controller.pin.length > 2),
                        const SizedBox(width: 16),
                        pinHint(controller.pin.length > 3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                  helpText == null
                      ? Container(
                          height: 20,
                        )
                      : Text(
                          helpText!,
                          style: DPTypography.itemDescription(color: DPColors.grayscale500).copyWith(decoration: TextDecoration.underline),
                        )
                ],
              ),
            ),
            Expanded(
              child: Padding(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
