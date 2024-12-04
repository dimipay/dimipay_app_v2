import 'package:dimipay_app_v2/app/services/admin/cancel_transaction/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CancelTransactionPageController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();
  CancelTransactionService cancelTransactionService = Get.find<CancelTransactionService>();

  final _isCancelTransactionProgress = false.obs;
  bool get isCancelTransactionProgress => _isCancelTransactionProgress.value;

  void onQRViewCreated(QRViewController controller) {
    this.qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        codeController.text = scanData.code!;
        qrViewController?.pauseCamera();
        Get.back();
        update(['codeField']);
      }
    });
  }

  void startScanning() {
    Get.to(() => QRScanView(controller: this));
  }

  Future<void> cancelTransaction() async {
    if (codeController.text.isEmpty) {
      Get.snackbar('오류', '결제 코드를 입력하거나 QR코드를 스캔해주세요');
      return;
    }

    _isCancelTransactionProgress.value = true;
    try {
      await cancelTransactionService.cancelTransaction(transactionId: codeController.text);
      DPSnackBar.open('결제 취소에 성공했어요.');
    } catch (e) {
      DPErrorSnackBar().open('결제 취소에 실패했어요.');
    } finally {
      _isCancelTransactionProgress.value = false;
    }
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    codeController.dispose();
    codeFocusNode.dispose();
    super.dispose();
  }
}

class QRScanView extends StatelessWidget {
  final CancelTransactionPageController controller;

  const QRScanView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: QRView(
        key: controller.qrKey,
        onQRViewCreated: controller.onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }
}