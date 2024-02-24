import 'package:animated_digit/animated_digit.dart';
import 'package:dimipay_app_v2/app/pages/transaction/controller.dart';
import 'package:dimipay_app_v2/app/pages/transaction/widget/transaction_date_group.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionPage extends GetView<TransactionPageController> {
  const TransactionPage({super.key});

  Widget _transaction() {
    return controller.transactionService.obx(
      (transactions) {
        if (transactions!.isEmpty) {
          return const Center(child: Text('결제 내역이 없네요!'));
        }
        return Obx(() {
          final Map<DateTime, List<Transaction>> transactionsGroupedByDate = {};

          for (var transaction in transactions) {
            if (transactionsGroupedByDate.containsKey(transaction.createdAt)) {
              transactionsGroupedByDate[transaction.createdAt]?.add(transaction);
            } else {
              transactionsGroupedByDate[transaction.createdAt] = [transaction];
            }
          }

          return Scrollbar(
            controller: controller.scrollController,
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  ...transactionsGroupedByDate.entries.map((e) => TransactionDateGroup(date: e.key, transactions: e.value)).toList(),
                  !controller.transactionService.hasReachedEnd
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: DPColors.primaryBrand,
                            strokeWidth: 2,
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        });
      },
      onLoading: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: DPColors.primaryBrand,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('결제 내역', style: DPTypography.header1(color: DPColors.grayscale1000)),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.minusMonth();
                            },
                            icon: const Icon(Icons.chevron_left),
                          ),
                          Obx(
                            () => Text(
                              DateFormat('yyyy년 M월').format(controller.date.value),
                              style: DPTypography.description(color: DPColors.grayscale800),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.plusMonth();
                            },
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              '총 ',
                              style: DPTypography.header2(color: DPColors.primaryBrand),
                            ),
                            AnimatedDigitWidget(
                              value: controller.transactionService.totalPrice ?? 0,
                              textStyle: DPTypography.header2(color: DPColors.primaryBrand),
                              enableSeparator: true,
                            ),
                            Text(
                              '원',
                              style: DPTypography.header2(color: DPColors.primaryBrand),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 6, color: DPColors.grayscale200),
          Expanded(child: _transaction()),
        ],
      ),
    );
  }
}
