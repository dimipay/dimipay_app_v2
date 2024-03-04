import 'dart:developer';

import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/repository.dart';
import 'package:get/get.dart';

class PaymentService extends GetxController {
  final PaymentRepository repository;

  PaymentService({PaymentRepository? repository}) : repository = repository ?? PaymentRepository();

  final Rx<String?> _mainMethodId = Rx(null);
  PaymentMethod? get mainMethod => paymentMethods?.firstWhereOrNull((payment) => payment.id == _mainMethodId.value);

  final Rx<List<PaymentMethod>?> _paymentMethods = Rx(null);
  List<PaymentMethod>? get paymentMethods => _paymentMethods.value;

  Future<void> fetchPaymentMethods() async {
    try {
      Map data = await repository.getPaymentMethod();

      log(data.toString());

      _mainMethodId.value = data["mainMethodId"];
      _paymentMethods.value = data["paymentMethods"];
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createPaymentMethod({
    required String name,
    required String number,
    required String year,
    required String month,
    required String idNo,
    required String pw,
    required String ownerName,
  }) async {
    PaymentMethod newPaymentMethod = await repository.createPaymentMethod(
      name: name,
      number: number,
      year: year,
      month: month,
      idNo: idNo,
      pw: pw,
      ownerName: ownerName,
    );
    paymentMethods?.add(newPaymentMethod);
    _paymentMethods.refresh();
  }

  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    try {
      paymentMethods?.remove(paymentMethod);
      _paymentMethods.refresh();
      await repository.deletePaymentMethod(id: paymentMethod.id);
    } catch (e) {
      paymentMethods?.add(paymentMethod);
      _paymentMethods.refresh();
      rethrow;
    }
  }
}
