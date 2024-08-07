import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/service.dart';
import 'package:get/get.dart';

class TransactionDetailPageController extends GetxController with StateMixin {
  final String transactionId = Get.arguments?['transactionId'];
  final TransactionService transactionService = Get.find<TransactionService>();
  final Rx<TransactionDetail?> _transaction = Rx(null);
  TransactionDetail? get transaction => _transaction.value;

  Future<void> hapticEffect() async {
    await HapticHelper.feedback(HapticPattern([200, 250, 300, 400, 500, 650, 800, 1050]), hapticType: HapticType.light);
  }

  Future<void> getTransaction() async {
    _transaction.value = await transactionService.getTransactionDetail(transactionId);
    hapticEffect();
    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    getTransaction();
    super.onInit();
  }
}
