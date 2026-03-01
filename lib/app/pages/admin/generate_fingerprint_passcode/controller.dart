import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateFingerprintPasscodePageController extends GetxController {
  final FingerprintKioskService fingerprintKioskService =
      Get.find<FingerprintKioskService>();

  final TextEditingController lifeController =
      TextEditingController(text: '60');
  final FocusNode lifeFocusNode = FocusNode();

  final RxBool _isGenerating = false.obs;
  final RxString _life = '60'.obs;

  bool get isGenerating => _isGenerating.value;
  bool get isLifeValid {
    final int? life = int.tryParse(_life.value);
    if (life == null) {
      return false;
    }
    return life >= FingerprintKioskService.minLifeSeconds &&
        life <= FingerprintKioskService.maxLifeSeconds;
  }

  @override
  void onInit() {
    super.onInit();
    _setupLifeListener();
  }

  void _setupLifeListener() {
    lifeController.addListener(() {
      _life.value = lifeController.text;
    });
  }

  Future<void> generatePasscode() async {
    final int? life = int.tryParse(lifeController.text);
    if (life == null) {
      DPErrorSnackBar().open('숫자만 입력해주세요.');
      return;
    }
    if (!isLifeValid) {
      DPErrorSnackBar().open(
        '${FingerprintKioskService.minLifeSeconds}초부터 ${FingerprintKioskService.maxLifeSeconds}초 사이로 입력해주세요.',
      );
      return;
    }

    _isGenerating.value = true;
    update(['lifeField']);

    try {
      await fingerprintKioskService.generatePasscode(life: life);
    } on Exception {
      DPErrorSnackBar().open('지문 키오스크 패스코드 생성에 실패했어요.');
    } finally {
      _isGenerating.value = false;
      update(['lifeField']);
    }
  }

  @override
  void onClose() {
    lifeController.dispose();
    lifeFocusNode.dispose();
    fingerprintKioskService.resetPasscode();
    super.onClose();
  }
}
