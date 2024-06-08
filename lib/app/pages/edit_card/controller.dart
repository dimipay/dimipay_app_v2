import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditCardPageController extends GetxController with StateMixin {
  PaymentMethod paymentMethod = Get.arguments?['paymentMethod'];
  TextEditingController nameFieldController = TextEditingController();
  Rx<String?> errorMessage = Rx(null);
  Rx<String> nameFieldText = Rx('');
  PaymentService paymentService = Get.find<PaymentService>();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    nameFieldController.addListener(
      () {
        nameFieldText.value = nameFieldController.text;
      },
    );
    nameFieldController.addListener(() {
      String newName = nameFieldController.text;
      String? res = validateName(newName);
      errorMessage.value = res;
    });
    nameFieldController.text = paymentMethod.name;
    nameFieldController.selection = TextSelection(baseOffset: 0, extentOffset: nameFieldController.text.length);
    super.onInit();
  }

  String? validateName(String name) {
    if (name.isEmpty) {
      return '';
    }
    if (name != name.trim()) {
      return '시작과 끝에는 공백 문자가 올 수 없어요.';
    }

    bool res = RegExp(r'^[0-9a-zA-Z\sㄱ-ㅎㅏ-ㅣ가-힣]*$').hasMatch(name);
    if (res) {
      return null;
    } else {
      return '한글, 영어, 숫자, 공백 문자만 쓸 수 있어요.';
    }
  }

  Future<void> editCardName() async {
    String newName = nameFieldController.text;
    if (validateName(newName) != null) {
      return;
    }
    try {
      change(null, status: RxStatus.loading());
      await paymentService.editPaymentMethodName(paymentMethod: paymentMethod, newName: newName);
      Get.back();
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  @override
  void onClose() {
    nameFieldController.dispose();
    super.onClose();
  }
}
