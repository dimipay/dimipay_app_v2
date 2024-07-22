import 'package:dimipay_app_v2/app/pages/payment/controller.dart';
import 'package:dimipay_app_v2/app/pages/payment/widget/payment_action_bottom_sheet.dart';
import 'package:dimipay_app_v2/app/pages/payment/widget/payment_item.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/divider.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DPAppbar(header: '결제 수단'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Text('카드', style: textTheme.header2.copyWith(color: colorTheme.grayscale900)),
                const SizedBox(width: 8),
                Obx(() => Text(controller.paymentService.paymentMethods?.length.toString() ?? '0', style: textTheme.header2.copyWith(color: colorTheme.primaryBrand))),
                const Spacer(),
                DPGestureDetectorWithOpacityInteraction(
                  onTap: () => Get.toNamed(Routes.REGISTER_CARD),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorTheme.grayscale600,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text('추가하기',
                        style: textTheme.readable.copyWith(
                          color: colorTheme.grayscale100,
                        )),
                  ),
                )
              ],
            ),
          ),
          const DPDivider(),
          Expanded(
            child: Obx(() {
              if (controller.paymentService.paymentMethods == null) {
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: colorTheme.primaryBrand,
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                return ListView(
                  physics: const BouncingScrollPhysics(),
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
                );
              }
            }),
          ),
        ],
      ),
    ));
  }
}
