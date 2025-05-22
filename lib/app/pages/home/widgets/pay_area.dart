import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/payment_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/qr_area.dart';
import 'package:dimipay_app_v2/app/services/pay/state.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TokenLifeTimeIndicator extends StatefulWidget {
  const TokenLifeTimeIndicator({
    super.key,
    required this.expireAt,
    required this.lifetime,
  });
  final DateTime expireAt;
  final Duration lifetime;

  @override
  State<TokenLifeTimeIndicator> createState() => _TokenLifeTimeIndicatorState();
}

class _TokenLifeTimeIndicatorState extends State<TokenLifeTimeIndicator> with TickerProviderStateMixin {
  AnimationController? animationController;
  late Animation<double> _animation;
  final int totalSeconds = 30;

  void initAnimation() {
    animationController?.dispose();

    final remainingTime = widget.expireAt.difference(DateTime.now());
    final startValue = 1 - (remainingTime.inSeconds / totalSeconds);

    animationController = AnimationController(
      duration: remainingTime,
      vsync: this,
    );

    _animation = Tween<double>(
        begin: startValue,
        end: 1.0
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.linear,
    ));

    animationController!.forward();

    animationController!.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void didUpdateWidget(covariant TokenLifeTimeIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expireAt != widget.expireAt) {
      initAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    final remainingSeconds = (totalSeconds * (1 - _animation.value)).ceil();

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 34.0,
          height: 34.0,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            value: _animation.value,
            color: colorTheme.grayscale400,
          ),
        ),
        Text(
            remainingSeconds.toString(),
            style: textTheme.token.copyWith(color: colorTheme.grayscale600)
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}

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
                  switch (controller.payService.paymentTokenState) {
                    case PaymentTokenSuccess(expireAt: final expireAt, lifetime: final lifetime):
                      return TokenLifeTimeIndicator(expireAt: expireAt, lifetime: lifetime);
                    default:
                      return Container();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() {
            switch (controller.payService.paymentTokenState) {
              case PaymentTokenInitial():
                return controller.paymentService.mainMethod == null ? const QRAreaNoPaymentRegistered() : const QRAreaLocked();
              case PaymentTokenLoading() || PaymentTokenFailed():
                return const QRAreaLoading();
              case PaymentTokenSuccess(value: final value):
                return QRArea(payload: value);
            }
          }),
          const SizedBox(height: 24),
          Obx(() {
            if (controller.selectedPaymentMethod == null) {
              return const PaymentAreaNoPaymentRegistered();
            } else {
              return PaymentArea(paymentMethod: controller.selectedPaymentMethod!);
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
            AspectRatio(aspectRatio: 1.5 / 1),
          ],
        ),
      ),
    );
  }
}
