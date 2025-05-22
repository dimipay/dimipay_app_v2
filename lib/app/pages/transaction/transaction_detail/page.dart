import 'package:animated_digit/animated_digit.dart';
import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/controller.dart';
import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/widget/data_item.dart';
import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/widget/product_item.dart';
import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/widget/qr_dialog.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup_scope.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetailPage extends GetView<TransactionDetailPageController> {
  const TransactionDetailPage({super.key});

  String getTransactionTypeString(TransactionType? transactionType) {
    switch (transactionType) {
      case TransactionType.APP_QR:
        return 'QR 코드';
      case TransactionType.FACESIGN:
        return 'Face Sign';
      case null:
        return '';
    }
  }

  String getTransactionStatusString(TransactionStatus transactionStatus) {
    switch (transactionStatus) {
      case TransactionStatus.CONFIRMED:
        return '승인 됨';
      case TransactionStatus.CANCELED:
        return '취소 됨';
      case TransactionStatus.FAILED:
        return '결제 실패';
    }
  }

  String getPurchaseTypeString(PurchaseType purchaseType) {
    switch (purchaseType) {
      case PurchaseType.GENERAL:
        return '사용 안함';
      case PurchaseType.COUPON:
        return '사용 함';
    }
  }

  bool isTransactionCanceled(TransactionStatus transactionStatus) {
    return TransactionStatus.CANCELED == transactionStatus;
  }

  void _showQRDialog(BuildContext context, String transactionId) {
    showDialog(
      context: context,
      builder: (context) => QRDialog(transactionId: transactionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Scaffold(
      body: DPAnimatedShowUp(
        wait: const Duration(milliseconds: 100),
        slideFrom: const Offset(8, 0),
        child: DPAnimatedShowUpScope(
          waitBetweenChildren: const Duration(milliseconds: 30),
          slideFrom: const Offset(0, 8),
          child: Column(
            children: [
              controller.obx(
                  (_) => !isTransactionCanceled(controller.transaction!.status) ?
                  DPAppbar(
                    trailing: DPGestureDetectorWithOpacityInteraction(
                      onTap: () => _showQRDialog(context, controller.transaction!.id),
                      child: Text('결제취소 요청하기', style: textTheme.paragraph2Underlined.copyWith(color: colorTheme.grayscale600)),
                    ),
                  ) : const SizedBox.shrink(),
                onLoading: const SizedBox.shrink(),
              ),
              Expanded(
                child: controller.obx(
                    (_) => Scrollbar(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Column(
                                  children: [
                                    Text('결제액', style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale600)),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        AnimatedDigitWidget(
                                          value: controller.transaction!.totalPrice,
                                          suffix: '원',
                                          textStyle: TextStyle(color: colorTheme.grayscale1000, fontSize: 28, fontWeight: FontWeight.w700, height: 1),
                                          enableSeparator: true,
                                          curve: Curves.easeInOutCubicEmphasized,
                                          duration: const Duration(milliseconds: 1500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 96),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DPAnimatedShowUpScopeItem(
                                      child: Text('구매한 상품', style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale600)),
                                    ),
                                    ...controller.transaction!.products.map((e) => DPAnimatedShowUpScopeItem(child: ProductItem(product: e))),
                                  ],
                                ),
                              ),
                              DPAnimatedShowUpScopeItem(child: Container(height: 6, color: colorTheme.grayscale200)),
                              const SizedBox(height: 8),
                              DPAnimatedShowUpScopeItem(child: DataItem(header: '결제 시각', value: DateFormat('yyyy년 M월 d일 H시 m분').format(controller.transaction!.localDate))),
                              DPAnimatedShowUpScopeItem(child: DataItem(header: '결제 카드', value: controller.transaction!.cardName ?? '')),
                              DPAnimatedShowUpScopeItem(child: DataItem(header: '결제 방식', value: getTransactionTypeString(controller.transaction!.transactionType))),
                              DPAnimatedShowUpScopeItem(child: DataItem(header: '결제 상태', value: getTransactionStatusString(controller.transaction!.status))),
                              DPAnimatedShowUpScopeItem(child: DataItem(header: '쿠폰 사용', value: getPurchaseTypeString(controller.transaction!.purchaseType))),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                    onLoading: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: colorTheme.primaryBrand,
                          strokeWidth: 2,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
