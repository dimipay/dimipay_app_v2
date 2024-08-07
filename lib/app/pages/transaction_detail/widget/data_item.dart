import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  final String header;
  final String value;
  const DataItem({super.key, required this.header, required this.value});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            header,
            style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale700),
          ),
        ],
      ),
    );
  }
}
