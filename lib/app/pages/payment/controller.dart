import 'dart:developer';

import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentPageController extends GetxController {
  final PaymentService paymentService = Get.find<PaymentService>();

  final Rx<String?> name = Rx(null);
  final Rx<String?> cardNumber = Rx(null);
  final Rx<DateTime?> expiredAt = Rx(null);
  final Rx<String?> ownerPersonalNum = Rx(null);
  final Rx<String?> password = Rx(null);

  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController cardNumberFieldController = TextEditingController();
  final TextEditingController expiredDateFieldController = TextEditingController();
  final TextEditingController ownerPersonalNumFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();

  @override
  void onInit() {
    super.onInit();
    nameFieldController.addListener(onNameChange);
    debounce(
        name,
        (callback) => {
              nameFieldController.text = callback!,
              formFocusScopeNode.nextFocus(),
            });
    cardNumberFieldController.addListener(onCardNumberChange);
    expiredDateFieldController.addListener(onExpireDateChange);
    ownerPersonalNumFieldController.addListener(onBirthdayChange);
    passwordFieldController.addListener(onPasswordChange);
  }

  void onNameChange() {
    String data = nameFieldController.text;
    if (data.isNotEmpty) {
      name.value = data;
    } else {
      name.value = null;
    }
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

  void onCardNumberChange() {
    String data = cardNumberFieldController.text;
    String rawData = data.replaceAll('-', '');
    String formatedData = formatCardNumber(rawData);
    if (data != formatedData) {
      cardNumberFieldController.text = formatedData;
      cardNumberFieldController.selection = TextSelection.fromPosition(TextPosition(offset: cardNumberFieldController.text.length));
      return;
    }
    if (data.length == 19) {
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

  void onExpireDateChange() {
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

  void onBirthdayChange() {
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

  void onPasswordChange() {
    String data = passwordFieldController.text;
    if (data.length == 2) {
      password.value = data;
      formFocusScopeNode.nextFocus();
    } else {
      password.value = null;
    }
  }

  void addPaymentMethod() {
    log('name: ${name.value}\n'
        'cardNumber: ${cardNumber.value}\n'
        'expiredAt: ${expiredAt.value}\n'
        'ownerPersonalNum: ${ownerPersonalNum.value}\n'
        'password: ${password.value}\n');

    String userName = Get.find<UserService>().user!.name;

    if (formKey.currentState!.validate()) {
      paymentService.createPaymentMethod(
          name: name.value!,
          number: cardNumber.value!,
          year: expiredAt.value!.year.toString().padLeft(2, '0'),
          month: expiredAt.value!.month.toString().padLeft(2, '0'),
          idNo: ownerPersonalNum.value!,
          pw: password.value!,
          ownerName: userName);
    }
  }
}
