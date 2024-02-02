import 'package:dimipay_app_v2/app/services/transaction/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPageController extends GetxController {
  final TransactionService transactionService = Get.find<TransactionService>();
  final ScrollController scrollController = ScrollController();

  Rx<DateTime> date = DateTime.now().obs;

  void minusMonth() {
    if (date.value.month == 1) {
      date.value = DateTime(date.value.year - 1, 12, 1);
    } else {
      date.value = DateTime(date.value.year, date.value.month - 1, 1);
    }

    transactionService.fetchTransactions(offset: date.value);
  }

  void plusMonth() {
    if (date.value.month == 12) {
      date.value = DateTime(date.value.year + 1, 1, 1);
    } else {
      date.value = DateTime(date.value.year, date.value.month + 1, 1);
    }

    transactionService.fetchTransactions(offset: date.value);
  }

  @override
  void onInit() async {
    super.onInit();
    if (transactionService.transactions == null) {
      transactionService.fetchTransactions();
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        transactionService.fetchMoreTransactions();
      }
    });
  }
}
