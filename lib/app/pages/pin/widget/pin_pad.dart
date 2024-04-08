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
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.3),
      children: [
        PinButton(
          onTap: () => onPinTap?.call(nums[0].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[0].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[1].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[1].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[2].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[2].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[3].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[3].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[4].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[4].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[5].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[5].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[6].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[6].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[7].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[7].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call(nums[8].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[8].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        faceIDAvailable
            ? PinButton(
                child: SvgPicture.asset(
                  'assets/icon/face_id.svg',
                  height: 24,
                  color: colorTheme.grayscale800,
                ),
                onTap: () => onFaceID?.call(),
              )
            : PinButton(child: Container()),
        PinButton(
          onTap: () => onPinTap?.call(nums[9].toString()),
          enabled: numpadEnabled,
          child: Text(
            nums[9].toString(),
            style: textTheme.header1.copyWith(
                fontWeight: Weight.medium,
                color: numpadEnabled
                    ? colorTheme.grayscale800
                    : colorTheme.grayscale400),
          ),
        ),
        PinButton(
          onTap: () => onPinTap?.call('del'),
          enabled: backBtnEnabled,
          child: SvgPicture.asset(
            'assets/icon/backspace.svg',
            width: 32,
            // ignore: deprecated_member_use
            color: backBtnEnabled ? colorTheme.grayscale800 : colorTheme.grayscale400,
          ),
        ),
      ],
    );
  }
}
