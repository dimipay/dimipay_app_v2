import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

import '../../../services/transaction/model.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function()? onTap;
  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${transaction.totalPrice}원',
              style: DPTypography.description(color: DPColors.grayscale800),
            ),
            const SizedBox(height: 4),
            Text(
              transaction.products.map((e) => e.name).toList().join(','),
              style: DPTypography.itemDescription(color: DPColors.grayscale600),
            ),
          ],
        ),
      ),
    );
  }
}
