import 'dart:io';

import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignPageController extends GetxController with StateMixin {
  final FaceSignService faceSignService = Get.find<FaceSignService>();
  final ImagePicker imagePicker = ImagePicker();

  Future<void> registerFaceSign() async {
    change(null, status: RxStatus.loading());
    try {
      XFile? imageData = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, maxHeight: 2048, maxWidth: 1024);
      if (imageData != null) {
        await faceSignService.registerFaceSign(imageData);
        HapticHelper.feedback(HapticPatterns.success);
      }
      change(null, status: RxStatus.success());
    } on FaceSignException catch (e) {
      change(null, status: RxStatus.error(e.message));
      DPErrorSnackBar().open(e.message);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> patchFaceSign() async {
    change(null, status: RxStatus.loading());
    try {
      XFile? imageData = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, maxHeight: 2048, maxWidth: 1024);
      if (imageData != null) {
        await faceSignService.patchFaceSign(imageData);
        DPSnackBar.open('Face Sign을 재등록했어요.');
        HapticHelper.feedback(HapticPatterns.success);
      }
      change(null, status: RxStatus.success());
    } on FaceSignException catch (e) {
      change(null, status: RxStatus.error(e.message));
      DPErrorSnackBar().open(e.message);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> deleteFaceSign() async {
    DPTypography textTheme = Theme.of(Get.context!).extension<DPTypography>()!;
    bool res = false;
    if (Platform.isIOS) {
      res = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          content: const Text('정말 Face Sign 등록을 삭제할까요?'),
          actions: [
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () => Get.back(result: false),
              child: Text('취소', style: textTheme.paragraph1.copyWith(color: Colors.blue)),
            ),
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () => Get.back(result: true),
              child: const Text('삭제'),
            ),
          ],
        ),
      );
    } else {
      res = await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          content: const Text('정말 Face Sign 등록을 삭제할까요?'),
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
    }

    if (res) {
      await faceSignService.deleteFaceSign();
    }
  }

  @override
  void onInit() {
    super.onInit();
    faceSignService.fetchIsFaceSignRegistered();
    change(null, status: RxStatus.success());
  }
}
