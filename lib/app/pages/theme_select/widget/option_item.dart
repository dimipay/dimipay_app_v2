import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionItem extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function()? onTap;
  const OptionItem({super.key, required this.title, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPButton(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(child: Text(title, style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale800))),
            selected ? SvgPicture.asset('assets/images/check.svg') : Container(),
          ],
        ),
      ),
    );
  }
}
