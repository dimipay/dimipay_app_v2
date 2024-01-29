import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:flutter/material.dart';

class DPPaymentQR extends StatelessWidget {
  final bool isLocked;

  const DPPaymentQR({Key? key, required this.isLocked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return Container(
        height: 132,
        decoration: const BoxDecoration(
          color: DPColors.grayscale200,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: DPColors.grayscale400,
            width: 1,
          )),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: DPColors.grayscale100,
                borderRadius: BorderRadius.all(Radius.circular(500)),
              ),
              child: const Icon(
                Icons.lock_rounded,
                size: 20,
                color: DPColors.grayscale500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '결제수단을 먼저 등록해 주세요.',
              style: DPTypography.token(color: DPColors.grayscale600),
            ),
          ],
        )),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          color: DPColors.grayscale100,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: DPColors.grayscale400,
            width: 1,
          )),
        ),
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
