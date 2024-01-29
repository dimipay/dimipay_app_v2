import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:flutter/material.dart';

class DPDivider extends StatelessWidget {
  const DPDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6,
      decoration: const BoxDecoration(
        color: DPColors.grayscale200,
      ),
    );
  }
}
