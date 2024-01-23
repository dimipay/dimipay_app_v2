import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:flutter/material.dart';

class DPAppbar extends StatelessWidget {
  final String header;
  final String? paragraph;

  const DPAppbar({super.key, required this.header, this.paragraph});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DPButton(
            onTap: () {},
            radius: BorderRadius.circular(20),
            isTapEffectEnabled: false,
            child: const Icon(Icons.arrow_back_ios_rounded,
                size: 20, color: DPColors.grayscale500),
          ),
          const SizedBox(height: 16),
          Text(
            header,
            style: DPTypography.header1(color: DPColors.grayscale1000),
          ),
          const SizedBox(height: 16),
          if (paragraph != null)
            Text(
              paragraph!,
              style: DPTypography.paragraph1(color: DPColors.grayscale700),
            ),
        ],
      ),
    );
  }
}
