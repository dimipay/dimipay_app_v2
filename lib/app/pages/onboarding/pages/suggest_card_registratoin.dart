import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestCardRegistratoinPage extends StatefulWidget {
  final OnboardingPageController controller;
  const SuggestCardRegistratoinPage({super.key, required this.controller});

  @override
  State<SuggestCardRegistratoinPage> createState() => _SuggestCardRegistratoinPageState();
}

class _SuggestCardRegistratoinPageState extends State<SuggestCardRegistratoinPage> {
  @override
  void initState() {
    Get.put(PaymentService(), permanent: true);
    Get.find<PaymentService>().fetchPaymentMethods();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Column(
      children: [
        const DPAppbar(header: '카드를 등록할까요?'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '앱에 카드를 등록해야 결제 키오스크에서 결제를 진행할 수 있어요.',
                      style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DPGestureDetectorWithOpacityInteraction(
                onTap: () {
                  widget.controller.nextPage();
                },
                child: Text('나중에 할래요', style: textTheme.paragraph2Underlined.copyWith(color: colorTheme.grayscale600)),
              ),
              const SizedBox(height: 24),
              DPButton(
                onTap: () async {
                  await Get.toNamed(Routes.REGISTER_CARD);
                  List<PaymentMethod>? paymentMethods = Get.find<PaymentService>().paymentMethods;
                  if (paymentMethods != null && paymentMethods.isNotEmpty) {
                    widget.controller.nextPage();
                  }
                },
                child: const Text('등록할래요'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
