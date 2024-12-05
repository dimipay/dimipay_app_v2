import 'dart:async';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/pages/pin/widget/pin_pad.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PinPageBase extends GetView<PinPageController> {
  final String headerText;
  final String? textSpan;
  final int? pinCount;
  final bool faceIDAvailable;
  final FutureOr<void> Function()? onPinComplete;
  const PinPageBase({
    super.key,
    required this.headerText,
    this.textSpan,
    this.pinCount,
    this.onPinComplete,
    this.faceIDAvailable = false,
  });

  bool get locked => pinCount != null && pinCount! <= 0;

  Future<void> openKakaoChannelTalk() async {
    try {
      await launchUrl(Uri.parse('https://pf.kakao.com/_gHxlCxj/chat?app_key=1127bc4e0b146e5579b6d6a2ad8d0ad1&kakao_agent=sdk%2F1.4.2+sdk_type%2Fflutter+os%2Fandroid-34+lang%2Fko-KR+origin%2FVNmybeVuZKt9uPyjMrvJ04STxtI%3D+device%2FA065+android_pkg%2Fcom.develop.dimipay+app_ver%2F1.1.0&api_ver=1.0'));
    } catch (error) {
      PlatformException exception = (error as PlatformException);
      if (exception.code != 'CANCELED') {
        DPErrorSnackBar().open('카카오톡을 통한 문의 채널 연결에 실패하였습니다.');
      }
    }
  }

  Widget pinHint(bool activated, DPColors colorTheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(
                children: [
                  Text(
                    locked ? '핀 시도 횟수를\n초과했습니다' : headerText,
                    style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  pinCount == null || locked
                      ? Container(height: 26)
                      : Text(
                          '$pinCount/5',
                          style: textTheme.header2.copyWith(color: colorTheme.primaryNegative),
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
                  const SizedBox(height: 32),
                  pinCount == null
                      ? Container(
                          height: 20,
                        )
                      : DPGestureDetectorWithOpacityInteraction(
                          duration: const Duration(milliseconds: 200),
                          onTap: openKakaoChannelTalk,
                          child: Text(
                            '핀을 잊어버렸어요',
                            style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale500).copyWith(decoration: TextDecoration.underline),
                          ),
                        )
                ],
              ),
            ),
            const Spacer(flex: 2),
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
          ],
        ),
      ),
    );
  }
}
