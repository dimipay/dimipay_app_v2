import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../services/admin/transactions/service.dart';

class CancelTransactionPageController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  final codeController = TextEditingController();
  final reasonController = TextEditingController();
  final codeFocusNode = FocusNode();
  final reasonFocusNode = FocusNode();
  TransactionsService transactionsService = Get.find<TransactionsService>();

  final _isCancelTransactionProgress = false.obs;
  final RxString _code = ''.obs;
  final RxString _reason = ''.obs;

  bool get isCancelTransactionProgress => _isCancelTransactionProgress.value;
  bool get isFormValid => _code.value.isNotEmpty && _reason.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    codeController.addListener(() {
      _code.value = codeController.text;
    });
    reasonController.addListener(() {
      _reason.value = reasonController.text;
    });
  }

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
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
    _isCancelTransactionProgress.value = true;
    try {
      await transactionsService.cancelTransaction(
        transactionId: codeController.text,
        reason: reasonController.text,
      );
      DPSnackBar.open('결제 취소에 성공했어요.');
    } on TransactionAlreadyCanceled catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on TransactionNotConfirmed catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on UnableToCancelTransaction catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on TransactionNotFound catch (e) {
      DPErrorSnackBar().open(e.message!);
    } on TransactionCancelFailed catch (e) {
      DPErrorSnackBar().open(e.message!);
    } catch (e) {
      DPErrorSnackBar().open("결제 취소에 실패했어요.");
    } finally {
      _isCancelTransactionProgress.value = false;
    }
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    codeController.dispose();
    reasonController.dispose();
    codeFocusNode.dispose();
    reasonFocusNode.dispose();
    super.dispose();
  }
}

class QRScanView extends StatelessWidget {
  final CancelTransactionPageController controller;

  const QRScanView({super.key, required this.controller});

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
