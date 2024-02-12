import 'package:dimipay_app_v2/app/pages/pin/widget/pin_button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PinPad extends StatelessWidget {
  final bool numpadEnabled;
  final bool backBtnEnabled;
  final bool faceIDAvailable;
  final void Function()? onFaceID;
  final void Function(String value)? onPinTap;
  final List<int> nums;
  const PinPad(this.nums, {super.key, this.onPinTap, this.onFaceID, this.numpadEnabled = true, this.backBtnEnabled = true, this.faceIDAvailable = false});

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
              faceIDAvailable
                  ? PinButton(
                      child: SvgPicture.asset('assets/images/face_id.svg', height: 24),
                      onTap: () => onFaceID?.call(),
                    )
                  : PinButton(child: Container()),
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
