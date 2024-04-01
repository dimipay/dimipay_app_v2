import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/payment_selection_bottom_sheet.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentArea extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const PaymentArea({super.key, required this.paymentMethod});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => const PaymentSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return DPButton(
      onTap: () => _showBottomSheet(context),
      isTapEffectEnabled: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/images/paymentRequired.svg', height: 40),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(paymentMethod.name ?? '', style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale800)),
              Text('이 카드로 결제', style: textTheme.token.copyWith(color: colorTheme.grayscale600)),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 12),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorTheme.grayscale500),
        ],
      ),
    );
  }
}

class PaymentAreaNoPaymentRegistered extends StatelessWidget {
  const PaymentAreaNoPaymentRegistered({super.key});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPButton(
      onTap: () => Get.toNamed(Routes.REGISTER_CARD),
      isTapEffectEnabled: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset('assets/images/paymentRequired.svg', height: 40),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('결제수단 등록하기', style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale800)),
              Text('등록된 결제수단이 없어요', style: textTheme.token.copyWith(color: colorTheme.grayscale600)),
            ],
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorTheme.grayscale500),
        ],
      ),
    );
  }
}