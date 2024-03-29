import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
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
                  style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale700),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.count}개',
                  style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale600),
                ),
              ],
            ),
          ),
          Text('${product.count * product.unitCost}원', style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale600)),
        ],
      ),
    );
  }
}
