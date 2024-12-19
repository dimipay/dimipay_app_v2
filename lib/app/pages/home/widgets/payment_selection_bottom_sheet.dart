import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup_scope.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/divider.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/network/service.dart';

class PaymentSelectionBottomSheet extends GetView<HomePageController> {
  final void Function(PaymentMethod paymentMethod)? onSelect;
  const PaymentSelectionBottomSheet({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final PaymentService paymentService = Get.find<PaymentService>();
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 42),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: colorTheme.grayscale100,
          child: DPAnimatedShowUpScope(
            waitBetweenChildren: const Duration(milliseconds: 30),
            wait: const Duration(milliseconds: 50),
            slideFrom: const Offset(0, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DPAnimatedShowUpScopeItem(child: const _TopIndicator()),
                const SizedBox(height: 20),
                DPAnimatedShowUpScopeItem(child: const _Heading(text: '결제수단 선택')),
                const SizedBox(height: 8),
                DPAnimatedShowUpScopeItem(
                  child: ConstrainedBox(
                    constraints: MediaQuery.of(context).size.height > 768 ? const BoxConstraints(maxHeight: 240.0) : const BoxConstraints(maxHeight: 160.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Obx(
                        () => Column(
                          children: (paymentService.paymentMethodsState as PaymentMethodsStateSuccess)
                              .value
                              .map(
                                (e) => _PaymentOption(
                                  title: e.name,
                                  subtitle: '**** **** **** ${e.preview}',
                                  assetPath: e.getLogoImagePath(),
                                  isSelected: controller.selectedPaymentMethod == e,
                                  onSelect: () => onSelect?.call(e),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                DPAnimatedShowUpScopeItem(child: const DPDivider()),
                DPAnimatedShowUpScopeItem(child: const _AddCardButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopIndicator extends StatelessWidget {
  const _TopIndicator();

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: colorTheme.grayscale300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;

  const _Heading({required this.text});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(text, style: textTheme.header2.copyWith(color: colorTheme.grayscale1000)),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetPath;
  final bool isSelected;
  final void Function()? onSelect;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.isSelected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPGestureDetectorWithFillInteraction(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(assetPath, height: 40),
            const SizedBox(width: 12),
            Expanded(
              child: _CardDetail(title: title, subtitle: subtitle),
            ),
            const SizedBox(width: 12),
            if (isSelected)
              Icon(
                Icons.check_rounded,
                color: colorTheme.primaryBrand,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const _CardDetail({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale800)),
        const SizedBox(height: 4),
        Text(subtitle, style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale600)),
      ],
    );
  }
}

class _AddCardButton extends GetView<HomePageController> {
  const _AddCardButton();

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    NetworkService networkService = Get.find<NetworkService>();

    return Obx(() {
      final isOffline = !networkService.isOnline;

      return Opacity(
        opacity: isOffline ? 0.5 : 1.0,
        child: DPGestureDetectorWithOpacityInteraction(
          onTap: isOffline
              ? null
              : () {
            Get.toNamed(Routes.REGISTER_CARD, preventDuplicates: false);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 26),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorTheme.grayscale200,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.credit_card, size: 24, color: colorTheme.grayscale600),
                ),
                const SizedBox(width: 12),
                Text('카드 추가하기', style: textTheme.description.copyWith(color: colorTheme.grayscale600)),
              ],
            ),
          ),
        ),
      );
    });
  }
}