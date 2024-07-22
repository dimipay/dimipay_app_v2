import 'package:animated_digit/animated_digit.dart';
import 'package:dimipay_app_v2/app/pages/transaction_detail/controller.dart';
import 'package:dimipay_app_v2/app/pages/transaction_detail/widget/data_item.dart';
import 'package:dimipay_app_v2/app/pages/transaction_detail/widget/product_item.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetailPage extends GetView<TransactionDetailPageController> {
  const TransactionDetailPage({super.key});

  String getTransactionTypeString(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.APP_QR:
        return 'QR 코드';
      case TransactionType.FACESIGN:
        return 'Face Sign';
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

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Scaffold(
      body: Column(
        children: [
          const DPAppbar(),
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
                                Text('구매한 상품', style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale600)),
                                ...controller.transaction!.products.map((e) => ProductItem(product: e)).toList(),
                              ],
                            ),
                          ),
                          Container(height: 6, color: colorTheme.grayscale200),
                          const SizedBox(height: 8),
                          DataItem(header: '결제 시각', value: DateFormat('yyyy년 M월 d일 H시 m분').format(controller.transaction!.localDate)),
                          DataItem(header: '결제 카드', value: controller.transaction!.cardName ?? ''),
                          DataItem(header: '결제 방식', value: getTransactionTypeString(controller.transaction!.transactionType)),
                          DataItem(header: '결제 상태', value: getTransactionStatusString(controller.transaction!.status)),
                          DataItem(header: '쿠폰 사용', value: getPurchaseTypeString(controller.transaction!.purchaseType)),
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
    );
  }
}
