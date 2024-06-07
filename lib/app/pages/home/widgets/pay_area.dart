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
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorTheme.grayscale100,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.fromBorderSide(BorderSide(
          color: colorTheme.grayscale300,
          width: 1,
        )),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('결제 QR', style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale900)),
                    Text('스캐너에 결제 QR을 찍어주세요', style: textTheme.token.copyWith(color: colorTheme.grayscale600)),
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
                        SizedBox(
                          width: 34.0,
                          height: 34.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            value: (60 - controller.timeRemaining.value!.inSeconds) / 60,
                            color: colorTheme.grayscale400,
                          ),
                        ),
                        Text(controller.timeRemaining.value!.inSeconds.toString(), style: textTheme.token.copyWith(color: colorTheme.grayscale600)),
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
            } else if (controller.authService.bioKey.key == null && controller.authService.pin == null) {
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
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Shimmer.fromColors(
      baseColor: colorTheme.grayscale300,
      highlightColor: colorTheme.grayscale200,
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.grayscale100,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale300,
            width: 1,
          )),
        ),
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
