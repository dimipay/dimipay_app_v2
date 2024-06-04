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

      _mainMethodId.value = data["mainMethodId"];
      _paymentMethods.value = data["paymentMethods"];
    } catch (e) {
      log(e.toString());
    }
  }

  @Deprecated("v2에서 사용 중지됨")
  Future<void> setMainMethod(PaymentMethod paymentMethod) async {
    await repository.patchMainMethod(id: paymentMethod.id);
    _mainMethodId.value = paymentMethod.id;
  }

  Future<PaymentMethod> createPaymentMethod({
    required String number,
    required String expireYear,
    required String expireMonth,
    required String idNumber,
    required String password,
  }) async {
    PaymentMethod newPaymentMethod = await repository.createPaymentMethod(
      number: number,
      expireYear: expireYear,
      expireMonth: expireMonth,
      idNumber: idNumber,
      password: password,
    );
    paymentMethods?.add(newPaymentMethod);
    _paymentMethods.refresh();
    return newPaymentMethod;
  }

  Future<PaymentMethod?> editPaymentMethodName({required PaymentMethod paymentMethod, required String newName}) async {
    int paymentMethodIndex = paymentMethods!.indexOf(paymentMethod);
    if (paymentMethodIndex == -1) {
      return null;
    }

    try {
      PaymentMethod newPaymentMethod = PaymentMethod(
        id: paymentMethod.id,
        name: newName,
        preview: paymentMethod.preview,
        companyCode: paymentMethod.companyCode,
      );
      paymentMethods![paymentMethodIndex] = newPaymentMethod;
      _paymentMethods.refresh();
      await repository.patchPaymentMethod(id: paymentMethod.id, name: newName);
      return newPaymentMethod;
    } catch (e) {
      paymentMethods![paymentMethodIndex] = paymentMethod;
      _paymentMethods.refresh();
      rethrow;
    }
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
