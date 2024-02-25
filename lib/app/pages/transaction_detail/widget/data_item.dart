import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  final String header;
  final String value;
  const DataItem({super.key, required this.header, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            header,
            style: DPTypography.paragraph2(color: DPColors.grayscale600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: DPTypography.itemTitle(color: DPColors.grayscale700),
          ),
        ],
      ),
    );
  }
}
