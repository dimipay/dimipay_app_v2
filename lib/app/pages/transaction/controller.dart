import 'package:dimipay_app_v2/app/services/transaction/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPageController extends GetxController {
  final TransactionService transactionService = Get.find<TransactionService>();
  final ScrollController scrollController = ScrollController();

  Rx<int> month = DateTime.now().month.obs;
  Rx<int> year = DateTime.now().year.obs;

  void minusMonth() {
    if (month.value == 1) {
      month.value = 12;
      year.value--;
    } else {
      month.value--;
    }

    DateTime newDate = DateTime(year.value, month.value, 1);
    String newDateStr = newDate.toIso8601String();

    transactionService.fetchTransactions(offset: newDateStr);
  }

  void plusMonth() {
    if (month.value == 12) {
      month.value = 1;
      year.value++;
    } else {
      month.value++;
    }

    DateTime newDate = DateTime(year.value, month.value, 1);
    String newDateStr = newDate.toIso8601String();

    transactionService.fetchTransactions(offset: newDateStr);
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
