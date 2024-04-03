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
  const PinPad(this.nums,
      {super.key,
        this.onPinTap,
        this.onFaceID,
        this.numpadEnabled = true,
        this.backBtnEnabled = true,
        this.faceIDAvailable = false});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return SizedBox(
      height: 320,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.6,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(12, (index) {
          if (index == 9) {
            return faceIDAvailable
                ? PinButton(
              child: SvgPicture.asset(
                'assets/images/face_id.svg',
                height: 24,
                color: colorTheme.grayscale800,
              ),
              onTap: () => onFaceID?.call(),
            )
                : PinButton(child: Container());
          } else if (index == 11) {
            return PinButton(
              onTap: () => onPinTap?.call('del'),
              enabled: backBtnEnabled,
              child: SvgPicture.asset(
                'assets/images/backspace.svg',
                width: 32,
                // ignore: deprecated_member_use
                color: backBtnEnabled ? colorTheme.grayscale800 : colorTheme.grayscale400,
              ),
            );
          } else {
            final num = nums[index == 10 ? 9 : index];
            return PinButton(
              onTap: () => onPinTap?.call(num.toString()),
              enabled: numpadEnabled,
              child: Text(
                num.toString(),
                style: textTheme.header1.copyWith(color: numpadEnabled ? colorTheme.grayscale800 : colorTheme.grayscale400),
              ),
            );
          }
        }),
      ),
    );

  }
}