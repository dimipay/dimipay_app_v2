import 'dart:developer';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterCardPageController extends GetxController with StateMixin {
  final PaymentService paymentService = Get.find<PaymentService>();

  final Rx<String?> cardNumber = Rx(null);
  final Rx<DateTime?> expiredAt = Rx(null);
  final Rx<String?> ownerPersonalNum = Rx(null);
  final Rx<String?> password = Rx(null);

  final TextEditingController cardNumberFieldController = TextEditingController();
  final TextEditingController expiredDateFieldController = TextEditingController();
  final TextEditingController ownerPersonalNumFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  String formatCardNumber(String rawData) {
    String formatedData = '';
    for (int i = 0; i < rawData.length; i++) {
      if (i != 0 && i % 4 == 0) {
        formatedData += '-';
      }
      formatedData += rawData[i];
    }
    return formatedData;
  }

  void onCardNumberChange(String str) {
    String data = cardNumberFieldController.text;
    String rawData = data.replaceAll('-', '');
    String formatedData = formatCardNumber(rawData);

    cardNumberFieldController.text = formatedData;
    cardNumberFieldController.selection = TextSelection.fromPosition(TextPosition(offset: cardNumberFieldController.text.length));

    if (rawData.length == 16) {
      cardNumber.value = rawData;
      formFocusScopeNode.nextFocus();
    } else {
      cardNumber.value = null;
    }
  }

  String formatExpireDate(String rawData) {
    String formatedData = '';
    for (int i = 0; i < rawData.length; i++) {
      if (i == 2) {
        formatedData += '/';
      }
      formatedData += rawData[i];
    }
    return formatedData;
  }

  void onExpireDateChange(String str) {
    String data = expiredDateFieldController.text;
    String rawData = data.replaceAll('/', '');
    String formatedData = formatExpireDate(rawData);
    if (data != formatedData) {
      expiredDateFieldController.text = formatedData;
      expiredDateFieldController.selection = TextSelection.fromPosition(TextPosition(offset: expiredDateFieldController.text.length));
      return;
    }
    if (data.length == 5) {
      expiredAt.value = DateTime(int.parse(rawData.substring(2)), int.parse(rawData.substring(0, 2)));
      formFocusScopeNode.nextFocus();
    } else {
      expiredAt.value = null;
    }
  }

  void onBirthdayChange(String str) {
    String data = ownerPersonalNumFieldController.text;
    if (data.length == 6) {
      ownerPersonalNum.value = DateFormat('yyyyMMdd').format(DateTime.parse("00$data")).substring(2);
    } else if (data.length == 10) {
      ownerPersonalNum.value = data;
      formFocusScopeNode.nextFocus();
    } else {
      ownerPersonalNum.value = null;
    }
  }

  void onPasswordChange(String str) {
    String data = passwordFieldController.text;
    if (data.length == 2) {
      password.value = data;
      formFocusScopeNode.unfocus();
    } else {
      password.value = null;
    }
  }

  Future<void> scanCreditCard() async {
    final CardDetails? cardInfo = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(
        scanCardHolderName: true,
      ),
    );

    if (cardInfo != null) {
      cardNumberFieldController.text = formatCardNumber(cardInfo.cardNumber);
      cardNumber.value = cardInfo.cardNumber;
      expiredDateFieldController.text = cardInfo.expiryDate;
      expiredAt.value = expiredAt.value = DateTime(int.parse(cardInfo.expiryDate.substring(3)), int.parse(cardInfo.expiryDate.substring(0, 2)));
      formFocusScopeNode.nextFocus();
      formFocusScopeNode.nextFocus();
      formFocusScopeNode.nextFocus();
    }
  }

  bool get isFormValid {
    return cardNumber.value != null && expiredAt.value != null && ownerPersonalNum.value != null && password.value != null;
  }

  void addPaymentMethod() async {
    if (isFormValid) {
      try {
        change(null, status: RxStatus.loading());
        PaymentMethod newPaymentMethod = await paymentService.createPaymentMethod(number: cardNumber.value!, expireYear: expiredAt.value!.year.toString().padLeft(2, '0'), expireMonth: expiredAt.value!.month.toString().padLeft(2, '0'), idNumber: ownerPersonalNum.value!, password: password.value!);

        Get.offNamed(Routes.EDIT_CARD, arguments: {'paymentMethod': newPaymentMethod});
      } on DioException catch (e) {
        log(e.response!.data.toString());
        DPErrorSnackBar().open(e.response!.data["message"]);
        HapticHelper.feedback(HapticPatterns.error);
      } finally {
        change(null, status: RxStatus.success());
      }
    }
  }

  @override
  void dispose() {
    cardNumberFieldController.dispose();
    expiredDateFieldController.dispose();
    ownerPersonalNumFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }
}
