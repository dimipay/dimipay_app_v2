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

    transactionService.getTransactions(year: date.value.year, month: date.value.month);
  }

  void plusMonth() {
    if (date.value.month == 12) {
      date.value = DateTime(date.value.year + 1, 1, 1);
    } else {
      date.value = DateTime(date.value.year, date.value.month + 1, 1);
    }

    transactionService.getTransactions(year: date.value.year, month: date.value.month);
  }

  // Future insertTransactions() async {
  // PaymentService paymentService = Get.find<PaymentService>();
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 12), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 11), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 10), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 9), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 8), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 7), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 5, 6), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 12), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 11), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 10), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 9), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 8), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 7), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 10, 6), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 1, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 6, 2, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 4, 5, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 3, 5, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 3, 3, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 3, 3, 10), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 3, 3, 12), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2023, 12, 5, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 4, 1, 11), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 4, 20, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  //   // await transactionService.createTransaction(createdAt: DateTime(2024, 4, 19, 14), status: 'CONFIRMED', transactionType: 'APP_QR', purchaseType: 'GENERAL', products: 3, paymentMethod: paymentService.paymentMethods!.first);
  // }

  @override
  void onInit() {
    super.onInit();
    if (transactionService.transactions == null) {
      transactionService.getTransactions(year: date.value.year, month: date.value.month);
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        transactionService.loadMoreTransactions();
      }
    });
    // insertTransactions();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
