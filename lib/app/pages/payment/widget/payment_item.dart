import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentItem extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final void Function()? onTap;
  final void Function()? onTapThreeDot;
  const PaymentItem({super.key, required this.paymentMethod, this.onTap, this.onTapThreeDot});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return DPGestureDetectorWithFillInteraction(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(paymentMethod.getLogoImagePath()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paymentMethod.name, style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale900)),
                  const SizedBox(height: 2),
                  Text('**** **** **** ${paymentMethod.preview}', style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale600)),
                ],
              ),
            ),
            Icon(
              Icons.more_vert,
              size: 18,
              color: colorTheme.grayscale500,
            ),
          ],
        ),
      ),
    );
  }
}
