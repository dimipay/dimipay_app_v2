import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRArea extends StatelessWidget {
  final String payload;

  const QRArea({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: DPColors.grayscale100,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: DPColors.grayscale400,
            width: 1,
          )),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: QrImageView(
          data: payload,
          version: QrVersions.auto,
        ),
      ),
    );
  }
}

class QRAreaLocked extends StatelessWidget {
  const QRAreaLocked({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? res = await showPinDialog();
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: const BoxDecoration(
            color: DPColors.grayscale200,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.fromBorderSide(BorderSide(
              color: DPColors.grayscale400,
              width: 1,
            )),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: DPColors.grayscale100,
                    borderRadius: BorderRadius.all(Radius.circular(500)),
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 20,
                    color: DPColors.grayscale500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'pin 또는 생체 인증 후 결제하기',
                  style: DPTypography.token(color: DPColors.grayscale600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QRAreaNoPaymentRegistered extends StatelessWidget {
  const QRAreaNoPaymentRegistered({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: DPColors.grayscale200,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: DPColors.grayscale400,
            width: 1,
          )),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: DPColors.grayscale100,
                  borderRadius: BorderRadius.all(Radius.circular(500)),
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  size: 20,
                  color: DPColors.grayscale500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '결제수단을 먼저 등록해 주세요.',
                style: DPTypography.token(color: DPColors.grayscale600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
