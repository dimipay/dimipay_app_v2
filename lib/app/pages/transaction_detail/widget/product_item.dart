import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '티즐 유자 그린티',
                  style: DPTypography.itemTitle(color: DPColors.grayscale700),
                ),
                const SizedBox(height: 4),
                Text(
                  'ㅇㅁㄹ',
                  style: DPTypography.paragraph2(color: DPColors.grayscale600),
                ),
              ],
            ),
          ),
          Text('1600원', style: DPTypography.itemDescription(color: DPColors.grayscale600)),
        ],
      ),
    );
  }
}
