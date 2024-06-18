import 'package:dimipay_app_v2/app/pages/register_card/controller.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart' as appbar;
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCardPage extends GetView<RegisterCardPageController> {
  const RegisterCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const appbar.DPAppbar(header: '카드 등록'),
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '신용/체크카드 등록 가능해요',
                              style: textTheme.itemDescription.copyWith(color: colorTheme.grayscale500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        FocusScope(
                          node: controller.formFocusScopeNode,
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildFormFields(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DPButton(
                    onTap: () => controller.scanCreditCard(),
                    backgroundColor: colorTheme.grayscale200,
                    foregroundColor: colorTheme.grayscale600,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: colorTheme.grayscale300,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flip_rounded, color: colorTheme.grayscale600, size: 20),
                        const SizedBox(width: 10),
                        const Text('카드 스캔하기'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  controller.obx(
                    (_) => Obx(
                      () {
                        if (controller.isFormValid) {
                          return DPButton(
                            onTap: controller.addPaymentMethod,
                            child: const Text('등록하기'),
                          );
                        } else {
                          return DPButton.disabled(
                            child: const Text('등록하기'),
                          );
                        }
                      },
                    ),
                    onLoading: DPButton.loading(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      DPTextField(
        controller: controller.cardNumberFieldController,
        labelText: '카드 번호',
        hintText: '0000-0000-0000-0000',
        maxLength: 19,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        hilightOnFocus: true,
        onChanged: controller.onCardNumberChange,
      ),
      _buildSpacer(),
      Row(
        children: [
          Expanded(
            child: DPTextField(
              controller: controller.expiredDateFieldController,
              labelText: '유효기간',
              hintText: 'MM/YY',
              maxLength: 5,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              hilightOnFocus: true,
              onChanged: controller.onExpireDateChange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DPTextField(
              controller: controller.ownerPersonalNumFieldController,
              labelText: '생년월일 / 사업자번호',
              hintText: '6 / 10자리',
              maxLength: 10,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              hilightOnFocus: true,
              onChanged: controller.onBirthdayChange,
            ),
          ),
        ],
      ),
      _buildSpacer(),
      DPTextField(
        controller: controller.passwordFieldController,
        labelText: '비밀번호',
        hintText: '앞 2자리',
        maxLength: 2,
        obscureText: true,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        hilightOnFocus: true,
        onChanged: controller.onPasswordChange,
      ),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildSpacer() => const SizedBox(height: 16);
}
