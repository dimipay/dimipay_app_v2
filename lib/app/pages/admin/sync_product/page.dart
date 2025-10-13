import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_app_v2/app/pages/admin/sync_product/controller.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SyncProductPage extends GetView<SyncProductPageController> {
  const SyncProductPage({super.key});

  Widget _buildBarcodeField() {
    return GetBuilder<SyncProductPageController>(
      id: 'barcodeField',
      builder: (_) => DPTextField(
        labelText: '상품 바코드',
        hintText: 'ex) 888132323',
        controller: controller.barcodeController,
        focusNode: controller.barcodeFocusNode,
        hilightOnFocus: true,
        keyboardType: TextInputType.number,
      ),
    );
  }
  
  Widget _buildQRScanButton(DPColors colorTheme) {
    return DPButton(
      onTap: controller.startScanning,
      backgroundColor: colorTheme.grayscale200,
      foregroundColor: colorTheme.grayscale600,
      border: Border.fromBorderSide(
        BorderSide(
          color: colorTheme.grayscale300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flip_rounded,
            color: colorTheme.grayscale600,
            size: 20,
          ),
          const SizedBox(width: 10),
          const Text('바코드 스캔하기'),
        ],
      ),
    );
  }

  Widget _buildSyncButton() {
    return Obx(
          () => controller.isSyncProductProgress
          ? DPButton.loading()
          : controller.isBarcodeValid
          ? DPButton(
        onTap: controller.syncProduct,
        child: const Text('가격 동기화'),
      )
          : DPButton.disabled(
        child: const Text('가격 동기화'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '상품 가격 동기화'),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildBarcodeField(),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildQRScanButton(colorTheme),
                  const SizedBox(height: 16.0),
                  _buildSyncButton(),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}