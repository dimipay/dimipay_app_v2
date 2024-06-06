import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

class QRArea extends StatelessWidget {
  final String payload;

  const QRArea({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale400,
            width: 1,
          )),
        ),
        child: Center(
          child: Container(
            width: 180,
            height: 180,
            child: QrImageView(
              data: payload,
              version: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class QRAreaLocked extends GetView<HomePageController> {
  const QRAreaLocked({super.key});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return GestureDetector(
      onTap: controller.requestAuthAndQR,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: colorTheme.grayscale200,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.fromBorderSide(BorderSide(
              color: colorTheme.grayscale400,
              width: 1,
            )),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorTheme.grayscale100,
                    borderRadius: const BorderRadius.all(Radius.circular(500)),
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 20,
                    color: colorTheme.grayscale500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'pin 또는 생체 인증 후 결제하기',
                  style: textTheme.token.copyWith(color: colorTheme.grayscale600),
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
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.grayscale200,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale400,
            width: 1,
          )),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorTheme.grayscale100,
                  borderRadius: const BorderRadius.all(Radius.circular(500)),
                ),
                child: Icon(
                  Icons.lock_rounded,
                  size: 20,
                  color: colorTheme.grayscale500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '결제수단을 먼저 등록해 주세요.',
                style: textTheme.token.copyWith(color: colorTheme.grayscale600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QRAreaLoading extends StatelessWidget {
  const QRAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale400,
            width: 1,
          )),
        ),
        child: Shimmer.fromColors(
          baseColor: colorTheme.grayscale300,
          highlightColor: colorTheme.grayscale200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
