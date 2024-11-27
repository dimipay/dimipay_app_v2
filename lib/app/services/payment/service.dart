import 'dart:async';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
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

    List<PaymentMethod> paymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).value;

    return paymentMethods.firstWhereOrNull((payment) => payment.id == _mainMethodId.value);
  }

  final StreamController<List<PaymentMethod>> _paymentStreamController = StreamController.broadcast();
  StreamSubscription<List<PaymentMethod>> get paymentStream => _paymentStreamController.stream.listen(null);

  final Rx<PaymentMethodsState> _paymentMethodsState = Rx(const PaymentMethodsStateInitial());
  PaymentMethodsState get paymentMethodsState => _paymentMethodsState.value;

  Future<void> _fetchPaymentMethodsFromCache() async {
    try {
      Map data = await repository.getPaymentMethodFromCache();

      if (paymentMethodsState is! PaymentMethodsStateSuccess) {
        _mainMethodId.value = data["mainMethodId"];
        _paymentMethodsState.value = PaymentMethodsStateSuccess(value: data["paymentMethods"]);
        _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).value);
      }
    } on CacheNotExistException {}
  }

  Future<void> _fetchPaymentMethodFromRemote() async {
    Map data = await repository.getPaymentMethod();

    _mainMethodId.value = data["mainMethodId"];
    _paymentMethodsState.value = PaymentMethodsStateSuccess(value: data["paymentMethods"]);
    _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).value);
  }

  Future<void> fetchPaymentMethods() async {
    try {
      _paymentMethodsState.value = const PaymentMethodsStateLoading();

      _fetchPaymentMethodsFromCache();
      _fetchPaymentMethodFromRemote();
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
    List<PaymentMethod> oldPaymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).value;

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
    List<PaymentMethod> newPaymentMethods = [...oldPaymentMethods, newPaymentMethod];

    _paymentMethodsState.value = PaymentMethodsStateSuccess(value: newPaymentMethods);
    _paymentStreamController.add((_paymentMethodsState.value as PaymentMethodsStateSuccess).value);
    repository.saveCurrentPaymentMethodsToCache(newPaymentMethods, mainMethod);
    return newPaymentMethod;
  }

  Future<PaymentMethod?> editPaymentMethodName({required PaymentMethod paymentMethod, required String newName}) async {
    List<PaymentMethod> oldPaymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).value;

    int paymentMethodIndex = oldPaymentMethods.indexOf(paymentMethod);
    if (paymentMethodIndex == -1) {
      return null;
    }

    try {
      PaymentMethod newPaymentMethod = paymentMethod.copyWith(name: newName);

      List<PaymentMethod> newPaymentMethods = [...oldPaymentMethods];
      newPaymentMethods[paymentMethodIndex] = newPaymentMethod;

      _paymentMethodsState.value = PaymentMethodsStateSuccess(value: newPaymentMethods);

      await repository.patchPaymentMethod(id: paymentMethod.id, name: newName);
      repository.saveCurrentPaymentMethodsToCache(newPaymentMethods, mainMethod);
      return newPaymentMethod;
    } catch (e) {
      _paymentMethodsState.value = PaymentMethodsStateSuccess(value: oldPaymentMethods);
      rethrow;
    } finally {
      _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).value);
    }
  }

  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    List<PaymentMethod> oldPaymentMethods = (paymentMethodsState as PaymentMethodsStateSuccess).value;
    try {
      List<PaymentMethod> newPaymentMethods = [...oldPaymentMethods];
      newPaymentMethods.remove(paymentMethod);
      _paymentMethodsState.value = PaymentMethodsStateSuccess(value: newPaymentMethods);

      await repository.deletePaymentMethod(id: paymentMethod.id);
      repository.saveCurrentPaymentMethodsToCache(newPaymentMethods, mainMethod);
      _mainMethodId.value = newPaymentMethods.firstWhereOrNull((element) => element.id == _mainMethodId.value)?.id ?? newPaymentMethods.firstOrNull?.id;
    } catch (e) {
      _paymentMethodsState.value = PaymentMethodsStateSuccess(value: oldPaymentMethods);
      rethrow;
    } finally {
      _paymentStreamController.add((paymentMethodsState as PaymentMethodsStateSuccess).value);
    }
  }
}
