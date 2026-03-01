import 'package:dimipay_app_v2/app/pages/admin/api_url_settings/controller.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/dp_textfield.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiUrlSettingsPage extends GetView<ApiUrlSettingsPageController> {
  const ApiUrlSettingsPage({super.key});

  Widget _buildUrlField() {
    return GetBuilder<ApiUrlSettingsPageController>(
      id: 'urlField',
      builder: (_) => DPTextField(
        labelText: 'API URL',
        hintText: 'https://prod-next.dimipay.io/',
        controller: controller.urlController,
        focusNode: controller.urlFocusNode,
        hilightOnFocus: true,
      ),
    );
  }

  Widget _buildCurrentUrlInfo(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorTheme.grayscale100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '현재 API URL',
            style: textTheme.token.copyWith(color: colorTheme.grayscale500),
          ),
          const SizedBox(height: 8),
          Text(
            controller.currentUrl,
            style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale800),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Obx(
      () => controller.isSaving
          ? DPButton.loading()
          : controller.isUrlValid
              ? DPButton(
                  onTap: controller.saveUrl,
                  child: const Text('저장'),
                )
              : DPButton.disabled(
                  child: const Text('저장'),
                ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;

    return DPButton(
      onTap: controller.resetToDefault,
      backgroundColor: colorTheme.grayscale200,
      child: Text(
        '기본값으로 초기화',
        style: TextStyle(color: colorTheme.grayscale700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: 'API URL 설정'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildCurrentUrlInfo(context),
                    const SizedBox(height: 24),
                    _buildUrlField(),
                    const Spacer(),
                    _buildResetButton(context),
                    const SizedBox(height: 12),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}