import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class DPDivider extends StatelessWidget {
  const DPDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Container(
      width: double.infinity,
      height: 6,
      decoration: BoxDecoration(
        color: colorTheme.grayscale200,
      ),
    );
  }
}
