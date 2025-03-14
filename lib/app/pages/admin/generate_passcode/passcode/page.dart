import 'dart:async';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/passcode/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasscodePage extends GetView<PasscodePageController> {
  const PasscodePage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(
              header: '패스코드',
            ),
            const Spacer(flex: 1),
            Obx(
              () => switch (controller.kioskService.passCodeState) {
                PasscodeStateInitial() || PasscodeStateLoading() || PasscodeStateFailed() => CircularProgressIndicator(
                    color: colorTheme.primaryBrand,
                  ),
                PasscodeStateSuccess(value: final passcode) => PasscodeDisplay(
                    passcode: passcode,
                    colorTheme: colorTheme,
                    textTheme: textTheme,
                  ),
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class PasscodeDisplay extends StatefulWidget {
  final dynamic passcode;
  final DPColors colorTheme;
  final DPTypography textTheme;

  const PasscodeDisplay({
    super.key,
    required this.passcode,
    required this.colorTheme,
    required this.textTheme,
  });

  @override
  State<PasscodeDisplay> createState() => _PasscodeDisplayState();
}

class _PasscodeDisplayState extends State<PasscodeDisplay> {
  late Timer _timer;
  late int _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.passcode.expiresIn;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
              color: isExpired ? widget.colorTheme.primaryNegative : widget.colorTheme.primaryBrand,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            widget.passcode.passcode,
            style: widget.textTheme.title.copyWith(color: widget.colorTheme.grayscale900, fontSize: 48),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          isExpired ? '만료됨!' : '$_remainingTime초 후 만료',
          style: widget.textTheme.header2.copyWith(color: widget.colorTheme.grayscale600),
        ),
      ],
    );
  }
}
