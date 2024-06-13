import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function()? onTap;
  const OptionItem({super.key, required this.title, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPGestureDetectorWithOpacityInteraction(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(child: Text(title, style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale800))),
            selected
                ? Icon(
                    Icons.check_rounded,
                    color: colorTheme.primaryBrand,
                    size: 24,
                  )
                : Container(height: 24),
          ],
        ),
      ),
    );
  }
}
