import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/payment_selection_bottom_sheet.dart';
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
              Text(paymentMethod.name ?? '', style: DPTypography.itemDescription(color: DPColors.grayscale800)),
              Text('이 카드로 결제', style: DPTypography.token(color: DPColors.grayscale600)),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: DPColors.grayscale500),
        ],
      ),
    );
  }
}

class PaymentAreaNoPaymentRegistered extends StatelessWidget {
  const PaymentAreaNoPaymentRegistered({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text('결제수단 등록하기', style: DPTypography.itemDescription(color: DPColors.grayscale800)),
              Text('등록된 결제수단이 없어요', style: DPTypography.token(color: DPColors.grayscale600)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: DPColors.grayscale500),
        ],
      ),
    );
  }
}
