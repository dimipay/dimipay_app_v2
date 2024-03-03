import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentActionBottomSheet extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const PaymentActionBottomSheet({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 42),
      decoration: BoxDecoration(
        color: DPColors.grayscale100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: DPColors.grayscale300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  paymentMethod.name ?? '',
                  style: DPTypography.header2(color: DPColors.grayscale1000),
                ),
                Text(
                  '****-****-****-${paymentMethod.last4Digit}',
                  style: DPTypography.description(color: DPColors.grayscale600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PaymentActionBottomSheetItem(
            title: '이름 수정하기',
            showIcon: true,
            onTap: () {},
          ),
          PaymentActionBottomSheetItem(
            title: '삭제하기',
            titleColor: DPColors.primaryNegative,
            onTap: () async {
              await Get.find<PaymentService>().deletePaymentMethod(paymentMethod);
              Get.back();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PaymentActionBottomSheetItem extends StatelessWidget {
  final String title;
  final Color titleColor;
  final bool showIcon;
  final void Function()? onTap;

  const PaymentActionBottomSheetItem({
    super.key,
    required this.title,
    this.onTap,
    this.showIcon = false,
    this.titleColor = DPColors.grayscale800,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: DPTypography.itemTitle(color: titleColor),
              ),
              showIcon ? const Icon(Icons.chevron_right, color: DPColors.grayscale500) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
