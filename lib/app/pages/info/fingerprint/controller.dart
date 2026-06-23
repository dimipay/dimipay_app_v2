import 'dart:io';

import 'package:dimipay_app_v2/app/services/fingerprint/service.dart';
import 'package:dimipay_app_v2/app/services/fingerprint/state.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FingerprintManagePageController extends GetxController {
  final FingerprintService fingerprintService = Get.find<FingerprintService>();

  final RxnString _deletingName = RxnString();
  String? get deletingName => _deletingName.value;

  bool isDeleting(String name) => deletingName == name;

  @override
  void onInit() {
    super.onInit();
    if (fingerprintService.fingerprintsState is! FingerprintsStateSuccess) {
      fetchFingerprints();
    }
  }

  Future<void> fetchFingerprints() async {
    await fingerprintService.fetchFingerprints();
  }

  Future<bool> showDeleteDialog(String name) async {
    DPTypography textTheme = Theme.of(Get.context!).extension<DPTypography>()!;

    if (Platform.isIOS) {
      final bool? result = await showCupertinoDialog<bool>(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          content: Text('$name 지문을 삭제하시겠습니까?'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(result: false),
              child: Text('취소',
                  style: textTheme.paragraph1.copyWith(color: Colors.blue)),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Get.back(result: true),
              child: const Text('삭제'),
            ),
          ],
        ),
      );
      return result ?? false;
    }

    final bool? result = await showDialog<bool>(
      context: Get.context!,
      builder: (context) => AlertDialog(
        content: Text('$name 지문을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> deleteFingerprint(String name) async {
    final bool confirmed = await showDeleteDialog(name);
    if (!confirmed) {
      return;
    }

    _deletingName.value = name;
    try {
      await fingerprintService.deleteFingerprint(name: name);
      DPSnackBar.open('지문을 삭제했어요.');
    } on Exception {
      DPErrorSnackBar().open('지문 삭제에 실패했어요.');
    } finally {
      _deletingName.value = null;
    }
  }
}
