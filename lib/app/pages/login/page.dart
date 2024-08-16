import 'package:dimipay_app_v2/app/pages/login/controller.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LogInPage extends GetView<LoginPageController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/logoTitle.svg',
                width: 16,
                height: 16,
                // ignore: deprecated_member_use
                color: colorTheme.grayscale900,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 36),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/login_page_image.svg'),
                  const SizedBox(height: 48),
                  Text('손 안에서, 손쉽게 결제하는 매점.', style: textTheme.header1.copyWith(color: colorTheme.grayscale1000)),
                  const SizedBox(height: 8),
                  Text('디미페이로 그 어느 때보다 간편하게 결제해보세요.', style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale700)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
              child: Obx(
                    () {
                  if (controller.isEmailPasswordLoginVisible.value) {
                    return PasswordLoginForm(controller: controller);
                  } else if (controller.isGoogleLoginInProgress) {
                    return DPButton.loading(
                      backgroundColor: colorTheme.grayscale200,
                      foregroundColor: colorTheme.primaryBrand,
                    );
                  } else {
                    return GoogleLoginButton(
                      onTap: controller.loginWithGoogle,
                      onLongPress: controller.showEmailPasswordLogin,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  const GoogleLoginButton({super.key, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return DPGestureDetectorWithOpacityInteraction(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.grayscale200,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icon/google-logo.svg'),
            const SizedBox(width: 10),
            Text(
              '디미고 구글 계정으로 로그인',
              style: textTheme.readable.copyWith(color: colorTheme.grayscale600),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordLoginForm extends StatelessWidget {
  final LoginPageController controller;

  const PasswordLoginForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Column(
      children: [
        DPTextField(
          hintText: 'Email',
          onChanged: controller.setEmail,
        ),
        const SizedBox(height: 16),
        DPTextField(
          hintText: 'Password',
          obscureText: true,
          onChanged: controller.setPassword,
        ),
        const SizedBox(height: 16),
        DPButton(
          onTap: controller.loginWithPassword,
          child: const Text('로그인'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: controller.hideEmailPasswordLogin,
          child: Text('구글 로그인으로 돌아가기', style: textTheme.paragraph1Underlined.copyWith(color: colorTheme.grayscale700)),
        ),
      ],
    );
  }
}