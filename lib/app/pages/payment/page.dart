import 'package:dimipay_app_v2/app/pages/payment/controller.dart';
import 'package:dimipay_app_v2/app/pages/payment/widget/payment_action_bottom_sheet.dart';
import 'package:dimipay_app_v2/app/pages/payment/widget/payment_item.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('결제 수단', style: DPTypography.header1(color: DPColors.grayscale1000)),
                    SizedBox(
                      height: 32,
                      child: FilledButton(
                        onPressed: () => Get.toNamed(Routes.REGISTER_CARD),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(DPColors.primaryBrand)),
                        child: const Text('추가하기'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.paymentService.paymentMethods == null) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: DPColors.primaryBrand,
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: controller.paymentService.paymentMethods!
                        .map((e) => PaymentItem(
                              paymentMethod: e,
                              onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                context: context,
                                builder: (context) => PaymentActionBottomSheet(paymentMethod: e),
                              ),
                            ))
                        .toList(),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
