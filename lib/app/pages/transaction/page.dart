import 'package:animated_digit/animated_digit.dart';
import 'package:dimipay_app_v2/app/pages/transaction/controller.dart';
import 'package:dimipay_app_v2/app/pages/transaction/widget/transaction_date_group.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/state.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup_scope.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionPage extends GetView<TransactionPageController> {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: DPAnimatedShowUp(
        wait: const Duration(milliseconds: 100),
        slideFrom: const Offset(16, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DPAppbar(header: '결제 내역'),
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
                              icon: Icon(
                                Icons.chevron_left,
                                color: colorTheme.grayscale500,
                              ),
                            ),
                            Obx(
                              () => Text(
                                DateFormat('yyyy년 M월').format(controller.date.value),
                                style: textTheme.description.copyWith(color: colorTheme.grayscale800),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.plusMonth();
                              },
                              icon: Icon(
                                Icons.chevron_right,
                                color: colorTheme.grayscale500,
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text(
                                '총 ',
                                style: textTheme.header2.copyWith(color: colorTheme.primaryBrand),
                              ),
                              AnimatedDigitWidget(
                                value: controller.transactionService.currentMonthTotal,
                                textStyle: textTheme.header2.copyWith(color: colorTheme.primaryBrand),
                                enableSeparator: true,
                              ),
                              Text(
                                '원',
                                style: textTheme.header2.copyWith(color: colorTheme.primaryBrand),
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
            Container(height: 6, color: colorTheme.grayscale200),
            Expanded(
              child: Obx(
                () => switch (controller.transactionService.transactionsState) {
                  TransactionsStateInitial() || TransactionsStateLoading() || TransactionsStateFailed() => Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: colorTheme.primaryBrand,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  TransactionsStateSuccess(value: final transactions) || TransactionsStateLoadingMore(value: final transactions) => transactions.isEmpty
                      ? Center(
                          child: Text(
                            '결제 내역이 없네요!',
                            style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale600),
                          ),
                        )
                      : Obx(
                          () {
                            final Map<DateTime, List<Transaction>> transactionsGroupedByDate = {};

                            for (final transaction in transactions) {
                              DateTime dateOnly = DateUtils.dateOnly(transaction.localDate);
                              if (transactionsGroupedByDate.containsKey(dateOnly)) {
                                transactionsGroupedByDate[dateOnly]?.add(transaction);
                              } else {
                                transactionsGroupedByDate[dateOnly] = [transaction];
                              }
                            }

                            return DPAnimatedShowUpScope(
                              waitBetweenChildren: const Duration(milliseconds: 20),
                              slideFrom: const Offset(0, 6),
                              child: Scrollbar(
                                controller: controller.scrollController,
                                child: SingleChildScrollView(
                                  controller: controller.scrollController,
                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  child: Column(
                                    children: [
                                      ...transactionsGroupedByDate.entries.map((e) => TransactionDateGroup(date: e.key, transactions: e.value)),
                                      !controller.transactionService.hasReachedEnd
                                          ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: colorTheme.primaryBrand,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
