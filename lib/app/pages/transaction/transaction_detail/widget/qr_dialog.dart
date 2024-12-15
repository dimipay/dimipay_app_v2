import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRDialog extends StatelessWidget {
  final String transactionId;

  const QRDialog({
    super.key,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '결제 ID',
              style: textTheme.itemTitle.copyWith(
                fontWeight: FontWeight.w600,
                color: colorTheme.grayscale1000,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '매니저님께 QR코드를 보여드리세요.',
              style: textTheme.itemDescription.copyWith(
                color: colorTheme.grayscale600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            QrImageView(
              data: transactionId,
              version: QrVersions.auto,
              size: 160,
            ),
            Text(
              transactionId,
              style: textTheme.hint.copyWith(
                color: colorTheme.grayscale600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '닫기',
                style: textTheme.paragraph2.copyWith(
                  color: colorTheme.primaryBrand,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}