import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/transaction/model.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function()? onTap;
  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPGestureDetectorWithScaleInteraction(
      onTap: () {},
      child: DPGestureDetectorWithOpacityInteraction(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${NumberFormat('###,###,###,###').format(transaction.totalPrice)}원',
                style: textTheme.description.copyWith(color: colorTheme.grayscale800),
              ),
              const SizedBox(height: 4),
              Text(
                transaction.products.join(', '),
                style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
