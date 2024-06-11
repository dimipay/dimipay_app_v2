import 'package:dimipay_app_v2/app/pages/edit_card/controller.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditCardPage extends GetView<EditCardPageController> {
  const EditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            const DPAppbar(header: '카드 이름 설정'),
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(controller.paymentMethod.getLogoImagePath()),
                      const SizedBox(width: 12),
                      Text('**** **** **** ${controller.paymentMethod.preview}', style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale500)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DPTextField(
                    autoFocus: true,
                    controller: controller.nameFieldController,
                    hintText: controller.paymentMethod.name,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.errorMessage.value ?? '',
                          style: textTheme.readable.copyWith(color: colorTheme.primaryNegative),
                        ),
                        Text(
                          '${controller.nameFieldText.value.length}/10',
                          style: textTheme.readable.copyWith(color: colorTheme.grayscale500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: controller.obx(
                (_) => Obx(() {
                  if (controller.validateName(controller.nameFieldText.value) == null) {
                    return DPButton(
                      onTap: controller.editCardName,
                      child: const Text('확인'),
                    );
                  } else {
                    return DPButton.disabled(
                      child: const Text('확인'),
                    );
                  }
                }),
                onLoading: DPButton.loading(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
