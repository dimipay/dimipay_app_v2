import 'dart:async';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/repository.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:get/get.dart';

class PaymentService extends GetxController {
  final PaymentRepository repository;

  PaymentService({PaymentRepository? repository}) : repository = repository ?? PaymentRepository();

  final Rx<String?> _mainMethodId = Rx(null);
  PaymentMethod? get mainMethod {
    if (paymentMethodsState is! PaymentMethodsStateSuccess) {
      return null;
    }

    List<PaymentMethod> paymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods;

    return paymentMethods.firstWhereOrNull((payment) => payment.id == _mainMethodId.value);
  }

  final StreamController<List<PaymentMethod>> _paymentStreamController = StreamController.broadcast();
  StreamSubscription<List<PaymentMethod>> get paymentStream => _paymentStreamController.stream.listen(null);

  final Rx<PaymentMethodsState> _paymentMethodsState = Rx(const PaymentMethodsStateInitial());
  PaymentMethodsState get paymentMethodsState => _paymentMethodsState.value;

  Future<void> fetchPaymentMethods() async {
    try {
      Map data = await repository.getPaymentMethod();

      _mainMethodId.value = data["mainMethodId"];
      _paymentMethodsState.value = PaymentMethodsStateSuccess(paymentMethods: data["paymentMethods"]);

      _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods);
    } on Exception catch (e) {
      _paymentMethodsState.value = PaymentMethodsStateFailed(exception: e);
    }
  }

  @override
  void onClose() {
    _paymentStreamController.close();
    super.onClose();
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
    List<PaymentMethod> oldPaymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods;

    PaymentMethod newPaymentMethod = await repository.createPaymentMethod(
      number: number,
      expireYear: expireYear,
      expireMonth: expireMonth,
      idNumber: idNumber,
      password: password,
    );
    if (oldPaymentMethods.isEmpty) {
      _mainMethodId.value = newPaymentMethod.id;
    }
    _paymentMethodsState.value = PaymentMethodsStateSuccess(paymentMethods: oldPaymentMethods + [newPaymentMethod]);
    _paymentStreamController.add((_paymentMethodsState.value as PaymentMethodsStateSuccess).paymentMethods);
    return newPaymentMethod;
  }

  Future<PaymentMethod?> editPaymentMethodName({required PaymentMethod paymentMethod, required String newName}) async {
    List<PaymentMethod> oldPaymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods;

    int paymentMethodIndex = oldPaymentMethods.indexOf(paymentMethod);
    if (paymentMethodIndex == -1) {
      return null;
    }

    try {
      PaymentMethod newPaymentMethod = PaymentMethod(
        id: paymentMethod.id,
        name: newName,
        preview: paymentMethod.preview,
        cardCode: paymentMethod.cardCode,
      );

      List<PaymentMethod> newPaymentMethods = [...oldPaymentMethods];
      newPaymentMethods[paymentMethodIndex] = newPaymentMethod;

      _paymentMethodsState.value = PaymentMethodsStateSuccess(paymentMethods: newPaymentMethods);

      await repository.patchPaymentMethod(id: paymentMethod.id, name: newName);
      return newPaymentMethod;
    } catch (e) {
      _paymentMethodsState.value = PaymentMethodsStateSuccess(paymentMethods: oldPaymentMethods);
      rethrow;
    } finally {
      _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods);
    }
  }

  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    List<PaymentMethod> oldPaymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods;
    try {
      List<PaymentMethod> newPaymentMethods = [...oldPaymentMethods];
      newPaymentMethods.remove(paymentMethod);
      _paymentMethodsState.value = PaymentMethodsStateSuccess(paymentMethods: newPaymentMethods);

      await repository.deletePaymentMethod(id: paymentMethod.id);
      _mainMethodId.value = newPaymentMethods.firstWhereOrNull((element) => element.id == _mainMethodId.value)?.id ?? newPaymentMethods.firstOrNull?.id;
    } catch (e) {
      _paymentMethodsState.value = PaymentMethodsStateSuccess(paymentMethods: oldPaymentMethods);
      rethrow;
    } finally {
      _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).paymentMethods);
    }
  }
}
