import 'package:dimipay_app_v2/app/core/theme/box_decorations.dart';
import 'package:dimipay_app_v2/app/pages/register_card/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCardPage extends GetView<RegisterCardPageController> {
  const RegisterCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '카드등록'),
            _buildCardRegistrationForm(),
            const Spacer(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardRegistrationForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '신용/체크카드 등록 가능해요',
                style:
                    DPTypography.itemDescription(color: DPColors.grayscale500),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: DPBoxDecorations.box1,
                    child: const Icon(Icons.check_rounded,
                        color: DPColors.grayscale500, size: 16),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '법인 카드',
                    style: DPTypography.itemDescription(
                        color: DPColors.grayscale600),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildFormFields(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextFormField(
        controller: controller.nameFieldController,
        focusNode: controller.nameFocusNode,
        labelText: '카드 이름',
        hintText: '카드 이름을 입력해주세요',
        maxLength: 20,
        isFieldFocused: controller.isTextFieldInFocus(controller.nameFocusNode),
      ),
      _buildSpacer(),
      _buildTextFormField(
        controller: controller.cardNumberFieldController,
        focusNode: controller.cardNumberFocusNode,
        labelText: '카드 번호',
        hintText: '0000-0000-0000-0000',
        maxLength: 19,
        keyboardType: TextInputType.number,
        isFieldFocused: controller.isTextFieldInFocus(controller.cardNumberFocusNode),
      ),
      _buildSpacer(),
      _buildRowFields(),
      _buildSpacer(),
      _buildTextFormField(
        controller: controller.passwordFieldController,
        focusNode: controller.passwordFocusNode,
        labelText: '카드 비밀번호',
        hintText: '앞 2자리',
        maxLength: 2,
        obscureText: true,
        keyboardType: TextInputType.number,
        isFieldFocused: controller.isTextFieldInFocus(controller.passwordFocusNode),
      ),
      _buildSpacer(),
      _buildTextFormField(
        controller: controller.ownerNameFieldController,
        focusNode: controller.ownerNameFocusNode,
        labelText: '카드 소유자 이름',
        hintText: '카드에 적혀있는 영문으로 입력해주세요',
        isFieldFocused: controller.isTextFieldInFocus(controller.ownerNameFocusNode),
      ),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildSpacer() => const SizedBox(height: 16);

  Widget _buildTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    required String hintText,
    int? maxLength,
    bool obscureText = false,
    TextInputType? keyboardType,
    required bool isFieldFocused,
  }) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: controller,
      focusNode: focusNode,
      decoration: DPBoxDecorations.inputDecoration(
        labelText: labelText,
        hintText: hintText,
        isFocused: isFieldFocused,
      ),
      style: DPTypography.description(color: DPColors.grayscale1000),
      maxLength: maxLength,
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }


  Widget _buildRowFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextFormField(
            controller: controller.expiredDateFieldController,
            focusNode: controller.expiredDateFocusNode,
            labelText: '유효기간',
            hintText: 'MM/YY',
            maxLength: 5,
            keyboardType: TextInputType.number,
            isFieldFocused: controller.isTextFieldInFocus(controller.expiredDateFocusNode),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextFormField(
            controller: controller.ownerPersonalNumFieldController,
            focusNode: controller.ownerPersonalNumFocusNode,
            labelText: '생년월일 / 사업자번호',
            hintText: '6 / 10자리',
            maxLength: 10,
            keyboardType: TextInputType.number,
            isFieldFocused: controller.isTextFieldInFocus(controller.ownerPersonalNumFocusNode),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          _buildScanCardButton(),
          const SizedBox(height: 16),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildScanCardButton() {
    return DPButton(
      decoration: DPBoxDecorations.box5,
      isTapEffectEnabled: true,
      radius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flip_rounded,
                color: DPColors.grayscale600, size: 20),
            const SizedBox(width: 10),
            Text('카드 스캔하기',
                style:
                    DPTypography.itemDescription(color: DPColors.grayscale600)),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return DPButton(
      decoration: DPBoxDecorations.box2,
      isTapEffectEnabled: true,
      radius: const BorderRadius.all(Radius.circular(10)),
      onTap: controller.addPaymentMethod,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('등록하기',
                style:
                    DPTypography.itemDescription(color: DPColors.grayscale100)),
          ],
        ),
      ),
    );
  }
}
