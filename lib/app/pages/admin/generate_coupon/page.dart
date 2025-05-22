import 'dart:io';

import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateCouponPage extends GetView<GenerateCouponPageController> {
  const GenerateCouponPage({super.key});

  Widget _textField(BuildContext context, TextEditingController controller) {
    final theme = Theme.of(context).extension<DPTypography>()!;
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: '개수 입력',
        suffix: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text('개 발급', style: theme.paragraph1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        keyboardType: TextInputType.number,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CupertinoColors.systemGrey4, width: 1),
        ),
        style: const TextStyle(fontSize: 16, color: CupertinoColors.black),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '개수 입력',
            suffixText: '개 발급',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      );
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context, TextEditingController _textFieldController, CouponType couponType) async {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    _textFieldController.text = '1';
    if (Platform.isIOS) {
      return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: _textField(context, _textFieldController),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(result: false),
              child: Text('취소',
                  style: textTheme.paragraph1.copyWith(color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () => Get.back(result: true),
              child: Text('생성',
                  style: textTheme.paragraph1.copyWith(color: Colors.blue)),
            ),
          ],
        ),
      );
    } else {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: _textField(context, _textFieldController),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('생성'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    TextEditingController _textFieldController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          const DPAppbar(
            header: '쿠폰 발급',
          ),
          Expanded(
            child: Obx(
              () => switch (controller.couponService.couponTypesState) {
                CouponTypesStateInitial() ||
                CouponTypesStateLoading() ||
                CouponTypesStateFailed() =>
                  Center(
                      child: CircularProgressIndicator(
                    color: colorTheme.primaryBrand,
                  )),
                CouponTypesStateSuccess(value: final couponTypes) => ListView(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const _SectionHeader(title: '쿠폰 종류'),
                      ...couponTypes.map(
                        (e) => _CouponTypeItem(
                          couponType: e,
                          onTap: () async {
                            bool confirm =
                                await _showConfirmationDialog(context, _textFieldController, e);
                            if (confirm) {
                              Get.toNamed(Routes.COUPON, arguments: { 'id': e.id, 'count': int.parse(_textFieldController.text) });
                            }
                          },
                        ),
                      ),
                    ],
                  )
              },
            ),
          )
        ],
      ),
    );
  }
}

class _CouponTypeItem extends StatelessWidget {
  final CouponType couponType;
  final void Function()? onTap;

  const _CouponTypeItem({
    required this.couponType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPGestureDetectorWithFillInteraction(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Row(
              children: [
                Text(
                  couponType.name,
                  style: textTheme.itemTitle
                      .copyWith(color: colorTheme.grayscale800),
                ),
                const SizedBox(width: 8),
                Text('${couponType.amount}원',
                    style: textTheme.paragraph2
                        .copyWith(color: colorTheme.grayscale700)),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: colorTheme.grayscale500),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(title,
          style: textTheme.token.copyWith(color: colorTheme.grayscale500)),
    );
  }
}
