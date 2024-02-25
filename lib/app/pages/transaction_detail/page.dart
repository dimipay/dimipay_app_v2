import 'package:animated_digit/animated_digit.dart';
import 'package:dimipay_app_v2/app/pages/transaction_detail/widget/data_item.dart';
import 'package:dimipay_app_v2/app/pages/transaction_detail/widget/product_item.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetailPage extends StatelessWidget {
  final Transaction transaction = Get.find<Transaction>();
  TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      children: [
                        Text('결제액', style: DPTypography.paragraph2(color: DPColors.grayscale600)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimatedDigitWidget(
                              value: transaction.totalPrice,
                              suffix: '원',
                              textStyle: const TextStyle(color: DPColors.grayscale1000, fontSize: 28, fontWeight: FontWeight.w700, height: 1),
                              enableSeparator: true,
                              curve: Curves.easeInOutCubicEmphasized,
                              duration: const Duration(milliseconds: 1500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DataItem(header: '결제 시각', value: DateFormat('yyyy년 M월 d일 H시 m분').format(transaction.createdAt)),
                  const DataItem(header: '결제 카드', value: '국민 카드'),
                  const DataItem(header: '결제 방식', value: 'QR 코드'),
                  Container(height: 6, color: DPColors.grayscale200),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('구매한 상품', style: DPTypography.paragraph2(color: DPColors.grayscale600)),
                        ...transaction.products.map((e) => ProductItem(product: e)).toList(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
