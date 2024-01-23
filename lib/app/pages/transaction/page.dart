import 'package:dimipay_app_v2/app/pages/transaction/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage extends GetView<TransactionPageController> {
  const TransactionPage({super.key});

  Widget _transaction() {
    return controller.transactionService.obx(
      (state) => ListView.builder(
        itemCount: state!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  state[index].totalPrice.toString(),
                ),
                subtitle: Text(
                  state[index].createdAt.toString(),
                ),
              ),
            ],
          );
        },
      ),
      onLoading: const Text(
        'loading...',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _transaction(),
          ],
        ),
      ),
    );
  }
}
