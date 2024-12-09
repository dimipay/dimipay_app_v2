import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/appbar.dart';
import '../../../widgets/button.dart';
import '../../../widgets/dp_textfield.dart';
import 'controller.dart';

class CancelTransactionPage extends GetView<CancelTransactionPageController> {
  const CancelTransactionPage({super.key});

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
          const Text('QR 스캔하기'),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return Obx(
          () => controller.isCancelTransactionProgress
          ? DPButton.loading()
          : controller.isFormValid
          ? DPButton(
        onTap: controller.cancelTransaction,
        child: const Text('결제 취소'),
      )
          : DPButton.disabled(
        child: const Text('결제 취소'),
      ),
    );
  }

  Widget _buildTransactionIdField() {
    return GetBuilder<CancelTransactionPageController>(
      id: 'codeField',
      builder: (_) => DPTextField(
        labelText: '결제 ID',
        hintText: '결제 ID를 입력하거나 QR을 스캔하세요',
        controller: controller.codeController,
        focusNode: controller.codeFocusNode,
        hilightOnFocus: true,
      ),
    );
  }

  Widget _buildReasonField() {
    return GetBuilder<CancelTransactionPageController>(
      id: 'reasonField',
      builder: (_) => DPTextField(
        labelText: '취소 사유',
        hintText: '취소 사유를 입력하세요',
        controller: controller.reasonController,
        focusNode: controller.reasonFocusNode,
        hilightOnFocus: true,
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
            const DPAppbar(header: '결제 취소'),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTransactionIdField(),
                  const SizedBox(height: 16.0),
                  _buildReasonField(),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildQRScanButton(colorTheme),
                  const SizedBox(height: 16.0),
                  _buildCancelButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}