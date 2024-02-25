import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

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
                  product.name,
                  style: DPTypography.itemTitle(color: DPColors.grayscale700),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.count}개',
                  style: DPTypography.paragraph2(color: DPColors.grayscale600),
                ),
              ],
            ),
          ),
          Text('${product.count * product.unitCost}원', style: DPTypography.itemDescription(color: DPColors.grayscale600)),
        ],
      ),
    );
  }
}
