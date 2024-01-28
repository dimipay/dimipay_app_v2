import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PinPage extends GetView<PinPageController> {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PinPageBase(
      headerText: '로그인을 완료하기 위해\n결제 핀을 입력해주세요',
      // pinCouont: 1,
      // helpText: '핀 번호를 잃어버렸어요',
    );
  }
}

class PinPageBase extends GetView<PinPageController> {
  final String headerText;
  final int? pinCouont;
  final String? helpText;
  const PinPageBase({super.key, required this.headerText, this.pinCouont, this.helpText});

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
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Text(
                    headerText,
                    style: DPTypography.header1(color: DPColors.grayscale1000),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  pinCouont == null
                      ? Container(height: 26)
                      : Text(
                          '${pinCouont}/5',
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
                    onPinTap: controller.onPinTap,
                    backBtnEnabled: controller.backBtnEnabled,
                    numpadEnabled: controller.numpadEnabled,
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

class PinButton extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final void Function()? onTap;
  const PinButton({required this.child, super.key, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          color: Colors.white,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class PinPad extends StatelessWidget {
  final bool numpadEnabled;
  final bool backBtnEnabled;
  final void Function(String value)? onPinTap;
  final List<int> nums;
  const PinPad(this.nums, {super.key, this.onPinTap, this.numpadEnabled = true, this.backBtnEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              PinButton(
                onTap: () => onPinTap?.call(nums[0].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[0].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call(nums[1].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[1].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call(nums[2].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[2].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              PinButton(
                onTap: () => onPinTap?.call(nums[3].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[3].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call(nums[4].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[4].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call(nums[5].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[5].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              PinButton(
                onTap: () => onPinTap?.call(nums[6].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[6].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call(nums[7].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[7].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call(nums[8].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[8].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              PinButton(child: Container()),
              PinButton(
                onTap: () => onPinTap?.call(nums[9].toString()),
                enabled: numpadEnabled,
                child: Text(
                  nums[9].toString(),
                  style: DPTypography.header1(color: numpadEnabled ? DPColors.grayscale800 : DPColors.grayscale400),
                ),
              ),
              PinButton(
                onTap: () => onPinTap?.call('del'),
                enabled: backBtnEnabled,
                child: SvgPicture.asset(
                  'assets/images/backspace.svg',
                  width: 32,
                  // ignore: deprecated_member_use
                  color: backBtnEnabled ? DPColors.grayscale800 : DPColors.grayscale400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
