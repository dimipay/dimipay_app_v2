import 'package:dimipay_app_v2/app/pages/payment/controller.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PaymentPage')),
      body: SafeArea(
          child: Column(
        children: [
          Obx(
            () => ListTile(
              title: Text(controller.mainPaymentMethod?.name ?? ""),
              subtitle: Text(controller.mainPaymentMethod?.last4Digit ?? ""),
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.paymentService.paymentMethods?.length ?? 0,
                  itemBuilder: (context, index) {
                    PaymentMethod paymentMethod = controller.paymentService.paymentMethods![index];
                    return ListTile(
                      title: Text(paymentMethod.name!),
                      subtitle: Text(paymentMethod.last4Digit),
                      trailing: IconButton(
                        onPressed: () {
                          controller.paymentService.deletePaymentMethod(paymentMethod);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                )),
          ),
        ],
      )),
    );
  }
}
