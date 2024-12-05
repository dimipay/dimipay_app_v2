import 'package:dimipay_app_v2/app/widgets/animations/animated_showup_scope.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function()? onTap;
  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPAnimatedShowUpScopeItem(
      key: ValueKey(transaction.id),
      child: DPGestureDetectorWithScaleInteraction(
        onTap: () {},
        child: DPGestureDetectorWithFillInteraction(
          effectBorderRadius: 12,
          effectPadding: const EdgeInsets.symmetric(horizontal: 4),
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
      ),
    );
  }
}
