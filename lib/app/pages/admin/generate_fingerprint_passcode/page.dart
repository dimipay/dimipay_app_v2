import 'dart:async';

import 'package:dimipay_app_v2/app/pages/admin/generate_fingerprint_passcode/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/model.dart';
import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/service.dart';
import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateFingerprintPasscodePage
    extends GetView<GenerateFingerprintPasscodePageController> {
  const GenerateFingerprintPasscodePage({super.key});

  Widget _buildLifeField() {
    return GetBuilder<GenerateFingerprintPasscodePageController>(
      id: 'lifeField',
      builder: (_) => DPTextField(
        labelText: '유효 시간(초)',
        hintText:
            '${FingerprintKioskService.minLifeSeconds}~${FingerprintKioskService.maxLifeSeconds}',
        controller: controller.lifeController,
        focusNode: controller.lifeFocusNode,
        hilightOnFocus: true,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildGenerateButton() {
    return Obx(
      () => controller.isGenerating
          ? DPButton.loading()
          : controller.isLifeValid
              ? DPButton(
                  onTap: controller.generatePasscode,
                  child: const Text('패스코드 생성'),
                )
              : DPButton.disabled(
                  child: const Text('패스코드 생성'),
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    final DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '지문 키오스크 패스코드 생성'),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildLifeField(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${FingerprintKioskService.minLifeSeconds}초 ~ ${FingerprintKioskService.maxLifeSeconds}초',
                  style: textTheme.paragraph2
                      .copyWith(color: colorTheme.grayscale500),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildGenerateButton(),
            ),
            const SizedBox(height: 32),
            Obx(
              () => switch (controller.fingerprintKioskService.passcodeState) {
                FingerprintPasscodeStateInitial() => const SizedBox.shrink(),
                FingerprintPasscodeStateLoading() =>
                  CircularProgressIndicator(color: colorTheme.primaryBrand),
                FingerprintPasscodeStateFailed() => Text(
                    '패스코드를 생성하지 못했습니다.',
                    style: textTheme.paragraph1
                        .copyWith(color: colorTheme.primaryNegative),
                  ),
                FingerprintPasscodeStateSuccess(value: final passcode) =>
                  FingerprintPasscodeDisplay(
                    key: ValueKey(passcode.passcode),
                    passcode: passcode,
                    colorTheme: colorTheme,
                    textTheme: textTheme,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FingerprintPasscodeDisplay extends StatefulWidget {
  final FingerprintPasscode passcode;
  final DPColors colorTheme;
  final DPTypography textTheme;

  const FingerprintPasscodeDisplay({
    super.key,
    required this.passcode,
    required this.colorTheme,
    required this.textTheme,
  });

  @override
  State<FingerprintPasscodeDisplay> createState() =>
      _FingerprintPasscodeDisplayState();
}

class _FingerprintPasscodeDisplayState
    extends State<FingerprintPasscodeDisplay> {
  late Timer _timer;
  late int _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.passcode.expiresIn;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpired = _remainingTime <= 0;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: widget.colorTheme.grayscale100,
            border: Border.all(
              color: isExpired
                  ? widget.colorTheme.primaryNegative
                  : widget.colorTheme.primaryBrand,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            widget.passcode.passcode,
            style: widget.textTheme.title
                .copyWith(color: widget.colorTheme.grayscale900, fontSize: 48),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          isExpired ? '만료됨!' : '$_remainingTime초 후 만료',
          style: widget.textTheme.header2
              .copyWith(color: widget.colorTheme.grayscale600),
        ),
      ],
    );
  }
}
