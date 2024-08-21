import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/services/admin/products/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyncProductPageController extends GetxController {
  final ProductsManageService productsManageService =
      Get.find<ProductsManageService>();

  TextEditingController barcodeController = TextEditingController();
  final FocusNode barcodeFocusNode = FocusNode();

  final RxBool _isSyncProductProgress = false.obs;

  bool get isSyncProductProgress => _isSyncProductProgress.value;

  Future<void> syncProduct() async {
    if (barcodeController.text.isEmpty) {
      DPErrorSnackBar().open('이메일을 입력해주세요.');
      return;
    }

    _isSyncProductProgress.value = true;
    update(['barcodeField']);

    try {
      await productsManageService.syncProduct(barcode: barcodeController.text);
      DPSnackBar.open('동기화에 성공했습니다.');
      barcodeController.clear();
    } on ProductNotFound catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on NoSellingPrice catch (e) {
      DPErrorSnackBar().open(e.message!);
    } catch (e) {
      DPErrorSnackBar().open('상품 동기화에 실패했어요.');
    } finally {
      _isSyncProductProgress.value = false;
      update(['barcodeField']);
    }
  }
}
