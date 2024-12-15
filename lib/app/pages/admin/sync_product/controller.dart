import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/services/admin/products/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyncProductPageController extends GetxController {
  final ProductsManageService _productsManageService = Get.find<ProductsManageService>();
  final TextEditingController barcodeController = TextEditingController();
  final FocusNode barcodeFocusNode = FocusNode();

  final RxBool _isSyncProductProgress = false.obs;
  final RxString _barcode = ''.obs;

  bool get isSyncProductProgress => _isSyncProductProgress.value;
  bool get isBarcodeValid => _barcode.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _setupBarcodeListener();
  }

  void _setupBarcodeListener() {
    barcodeController.addListener(() {
      _barcode.value = barcodeController.text;
    });
  }

  @override
  void onClose() {
    barcodeController.dispose();
    barcodeFocusNode.dispose();
    super.onClose();
  }

  Future<void> syncProduct() async {
    _isSyncProductProgress.value = true;
    update(['barcodeField']);

    try {
      await _productsManageService.syncProduct(barcode: barcodeController.text);
      DPSnackBar.open('상품 동기화에 성공했어요.');
      barcodeController.clear();
    } on ProductNotFound catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on NoSellingPrice catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on Exception {
      DPErrorSnackBar().open('상품 동기화에 실패했어요.');
    } finally {
      _isSyncProductProgress.value = false;
      update(['barcodeField']);
    }
  }
}
