import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:flutter/material.dart';

import '../styles/boxDecorations.dart';

class DPPaymentQR extends StatelessWidget {
  final bool isLocked;

  const DPPaymentQR({Key? key, required this.isLocked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return Container(
        decoration: DPBoxDecorations.container3,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: DPBoxDecorations.circle,
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 24,
                    color: DPColors.grayscale500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '결제수단을 먼저 등록해 주세요.',
                  style: DPTypography.token(color: DPColors.grayscale600),
                ),
              ],
            )
        ),
      );
    } else {
      return Container(
        decoration: DPBoxDecorations.container2,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Center(
          child: Image.asset(
            'assets/images/qrSample.png',
            width: 160,
            height: 160,
          ),
        ),
      );
    }
  }
}
