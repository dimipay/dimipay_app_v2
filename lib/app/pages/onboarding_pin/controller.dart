// ignore_for_file: prefer_is_empty

import 'dart:developer' as dev;

import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final String? redirect = Get.arguments?['redirect'];

  final Rx<List<int>> _nums = Rx([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  List<int> get nums => _nums.value;

  final Rx<String> _pin = Rx('');
  String get pin => _pin.value;

  bool get backBtnEnabled => pin.isNotEmpty && pin.length < 4;
  bool get numpadEnabled => pin.length < 4;

  @override
  void onInit() {
    _shufleList();
    super.onInit();
  }

  void _shufleList() {
    _nums.value.shuffle();
    _nums.refresh();
  }

  Future onboardingAuth(String pin) async {
    try {
      await authService.onBoardingAuth(pin);
      final String nextRoute = redirect ?? Routes.HOME;
      Get.offNamed(nextRoute);
    } catch (e) {
      rethrow;
    }
  }

  void onPinTap(String value) async {
    if (value == 'del') {
      if (pin.length > 0 && pin.length < 4) {
        _pin.value = pin.substring(0, pin.length - 1);
      }
      return;
    }
    _pin.value += value;
    dev.log(_pin.value);
    if (pin.length == 4) {
      try {
        await onboardingAuth(pin);
      } on IncorrectPinException catch (e) {
        DPErrorSnackBar().open(e.message);
      } finally {
        _pin.value = '';
      }
    }
  }
}
