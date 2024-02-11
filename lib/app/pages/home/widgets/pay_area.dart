import 'package:dimipay_app_v2/app/core/theme/box_decorations.dart';
import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/payment_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/qr_area.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PayArea extends GetView<HomePageController> {
  const PayArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: DPBoxDecorations.box3,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('결제 QR', style: DPTypography.itemTitle(color: DPColors.grayscale900)),
                    Text('스캐너에 결제 QR을 찍어주세요', style: DPTypography.token(color: DPColors.grayscale600)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Obx(
                () {
                  if (controller.timeRemaining.value == null) {
                    return Container();
                  } else {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: 34.0,
                          height: 34.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            // value: 1,
                            color: DPColors.grayscale400,
                          ),
                        ),
                        Text(controller.timeRemaining.value!.inSeconds.toString(), style: DPTypography.token(color: DPColors.grayscale600)),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() {
            controller.payService.paymentToken;
            if (controller.paymentService.mainMethod == null) {
              return const QRAreaNoPaymentRegistered();
            } else if (controller.authService.bioKey == null && controller.authService.pin == null) {
              return const QRAreaLocked();
            } else if (controller.payService.paymentToken == null) {
              return const QRAreaLoading();
            } else {
              return QRArea(payload: controller.payService.paymentToken!);
            }
          }),
          const SizedBox(height: 24),
          // PaymentAreaNoPaymentRegistered(),
          Obx(() {
            if (controller.paymentService.mainMethod == null) {
              return const PaymentAreaNoPaymentRegistered();
            } else {
              return PaymentArea(paymentMethod: controller.paymentService.mainMethod!);
            }
          })
        ],
      ),
    );
  }
}

class PayAreaLoading extends StatelessWidget {
  const PayAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DPColors.grayscale300,
      highlightColor: DPColors.grayscale200,
      child: Container(
        decoration: DPBoxDecorations.box3,
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            SizedBox(height: 128),
            AspectRatio(aspectRatio: 1),
          ],
        ),
      ),
    );
  }
}
