import 'package:dimipay_app_v2/app/pages/transaction/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage extends GetView<TransactionPageController> {
  const TransactionPage({super.key});

  Widget _transaction() {
    return controller.transactionService.obx(
      (state) {
        if (state!.isEmpty) {
          return const Center(child: Text('거래 내역이 없습니다.'));
        }
        return Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: state!.length + (controller.transactionService.hasReachedEnd.value ? 0 : 1),
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                if (index >= state.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
            ));
      },
      onLoading: const Center(
        child: Text(
          'loading...',
        ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    controller.minusMonth();
                  },
                  icon: const Icon(Icons.arrow_left),
                ),
                Obx(
                  () => Text(
                    controller.date.value.month.toString(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.plusMonth();
                  },
                  icon: const Icon(Icons.arrow_right),
                ),
              ],
            ),
            Expanded(child: _transaction()),
          ],
        ),
      ),
    );
  }
}
