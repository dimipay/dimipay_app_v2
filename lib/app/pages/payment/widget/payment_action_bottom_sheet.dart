import 'package:dimipay_app_v2/app/pages/payment/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentActionBottomSheet extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const PaymentActionBottomSheet({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 42),
      decoration: BoxDecoration(
        color: colorTheme.grayscale100,
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
                color: colorTheme.grayscale300,
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
                  paymentMethod.name,
                  style: textTheme.header2.copyWith(color: colorTheme.grayscale1000),
                ),
                Text(
                  '****-****-****-${paymentMethod.preview}',
                  style: textTheme.description.copyWith(color: colorTheme.grayscale600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PaymentActionBottomSheetItem(
            title: '이름 수정하기',
            showIcon: true,
            onTap: () {
              Get.back();
              Get.toNamed(Routes.EDIT_CARD, arguments: {'paymentMethod': paymentMethod});
            },
          ),
          PaymentActionBottomSheetItem(
            title: '삭제하기',
            titleColor: colorTheme.primaryNegative,
            onTap: () async {
              try {
                await Get.find<PaymentPageController>().deletePaymentMethod(paymentMethod);
                Get.back();
              } on DioException catch (e) {
                DPErrorSnackBar().open(e.response?.data['message'] ?? '');
              }
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
  final Color? titleColor;
  final bool showIcon;
  final void Function()? onTap;

  const PaymentActionBottomSheetItem({
    super.key,
    required this.title,
    this.onTap,
    this.showIcon = false,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
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
                style: textTheme.itemTitle.copyWith(color: titleColor ?? colorTheme.grayscale800),
              ),
              showIcon ? Icon(Icons.chevron_right, color: colorTheme.grayscale500) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
