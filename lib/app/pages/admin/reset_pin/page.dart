import 'package:dimipay_app_v2/app/pages/admin/reset_pin/controller.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPinPage extends GetView<ResetPinPageController> {
  const ResetPinPage({super.key});

  Widget _buildEmailField() {
    return GetBuilder<ResetPinPageController>(
      id: 'emailField',
      builder: (_) => DPTextField(
        labelText: '이메일',
        hintText: 'example@dimipay.io',
        controller: controller.emailController,
        focusNode: controller.emailFocusNode,
        hilightOnFocus: true,
      ),
    );
  }

  Widget _buildResetButton() {
    return Obx(
          () => controller.isResetPinProgress
          ? DPButton.loading()
          : controller.isEmailValid
          ? DPButton(
        onTap: controller.resetPin,
        child: const Text('핀 초기화'),
      )
          : DPButton.disabled(
        child: const Text('핀 초기화'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '사용자 핀 초기화'),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildEmailField(),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildResetButton(),
            ),
          ],
        ),
      ),
    );
  }
}