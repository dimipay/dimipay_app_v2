import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/repository.dart';
import 'package:get/get.dart';

class PaymentService extends GetxController {
  final PaymentRepository repository;

  PaymentService({PaymentRepository? repository}) : repository = repository ?? PaymentRepository();

  Rx<List<PaymentMethod>> _paymentMethods = Rx([]);
  List<PaymentMethod> get paymentMethods => _paymentMethods.value;

  Future<void> fetchPaymentMethods() async {
    _paymentMethods.value = await repository.getPaymentMethod();
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
    await repository.createPaymentMethod(
      name: name,
      number: number,
      year: year,
      month: month,
      idNo: idNo,
      pw: pw,
      ownerName: ownerName,
    );
  }
}
