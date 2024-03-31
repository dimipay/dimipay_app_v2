import 'package:dimipay_app_v2/app/core/theme/box_decorations.dart';
import 'package:dimipay_app_v2/app/pages/register_card/controller.dart';
import 'package:dimipay_app_v2/app/pages/register_card/widget/dp_textfield.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart' as appbar;
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
            const appbar.DPAppbar(header: '카드등록'),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    _buildCardRegistrationForm(),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
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
                style: DPTypography.itemDescription(color: DPColors.grayscale500),
              ),

              // const Spacer(),
              // Row(
              //   children: [
              //     Container(
              //       width: 24,
              //       height: 24,
              //       margin: const EdgeInsets.symmetric(horizontal: 4),
              //       decoration: DPBoxDecorations.box1,
              //       child: const Icon(Icons.check_rounded, color: DPColors.grayscale500, size: 16),
              //     ),
              //     const SizedBox(width: 10),
              //     Text(
              //       '법인 카드',
              //       style: DPTypography.itemDescription(color: DPColors.grayscale600),
              //     ),
              //   ],
              // )
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
    );
  }

  List<Widget> _buildFormFields() {
    return [
      DPTextField(
        controller: controller.nameFieldController,
        labelText: '카드 이름',
        hintText: '카드 이름을 입력해주세요',
        maxLength: 20,
        textInputAction: TextInputAction.next,
        autoFocus: true,
      ),
      _buildSpacer(),
      DPTextField(
        controller: controller.cardNumberFieldController,
        labelText: '카드 번호',
        hintText: '0000-0000-0000-0000',
        maxLength: 19,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
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
      ),
      _buildSpacer(),
      DPTextField(
        controller: controller.ownerNameFieldController,
        labelText: '소유자명',
        hintText: '카드에 적혀있는 영문으로 입력해주세요',
        textInputAction: TextInputAction.done,
        inputFormatters: [UpperCaseTextFormatter()],
      ),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildSpacer() => const SizedBox(height: 16);

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
      onTap: () => controller.scanCreditCard(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flip_rounded, color: DPColors.grayscale600, size: 20),
            const SizedBox(width: 10),
            Text('카드 스캔하기', style: DPTypography.itemDescription(color: DPColors.grayscale600)),
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: controller.obx(
            (state) => Text('등록하기', style: DPTypography.itemDescription(color: DPColors.grayscale100)),
            onLoading: const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            ),
          ),
        ),
      ),
    );
  }
}
