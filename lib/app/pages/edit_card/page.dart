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
      body: Column(
        children: [
          const DPAppbar(header: '카드 이름 설정'),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
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
                            '${controller.nameFieldTextLenth.value}/10',
                            style: textTheme.readable.copyWith(color: colorTheme.grayscale500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: DPButton(
              onTap: controller.editCardName,
              child: controller.obx(
                (state) => const Text('확인'),
                onLoading: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
