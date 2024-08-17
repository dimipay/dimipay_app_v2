import 'package:dimipay_app_v2/app/pages/login/pwlogin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PWLoginPage extends GetView<PWLoginPageController> {
  const PWLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                GetBuilder<PWLoginPageController>(
                  id: 'emailField',
                  builder: (_) => DPTextField(
                    labelText: '이메일',
                    hintText: 'example@dimipay.io',
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    hilightOnFocus: true,
                  ),
                ),
                const SizedBox(height: 16),
                GetBuilder<PWLoginPageController>(
                  id: 'passwordField',
                  builder: (_) => DPTextField(
                    labelText: '비밀번호',
                    hintText: 'your password',
                    obscureText: true,
                    controller: controller.pwController,
                    focusNode: controller.passwordFocusNode,
                    hilightOnFocus: true,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () {
                    if (controller.isLoginInProgress) {
                      return DPButton.loading();
                    } else {
                      return DPButton(
                        onTap: controller.loginWithPassword,
                        child: const Text('로그인'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Get.offNamed(Routes.LOGIN),
                  child: Text('구글 로그인으로 돌아가기',
                      style: textTheme.paragraph1Underlined
                          .copyWith(color: colorTheme.grayscale700)),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
