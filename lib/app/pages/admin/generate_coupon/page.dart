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

  Future<bool> _showConfirmationDialog(BuildContext context, CouponType couponType) async {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    if (Platform.isIOS) {
      return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text('${couponType.name} 쿠폰을 생성하시겠습니까?'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(result: false),
              child: Text('취소', style: textTheme.paragraph1.copyWith(color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () => Get.back(result: true),
              child: Text('생성', style: textTheme.paragraph1.copyWith(color: Colors.blue)),
            ),
          ],
        ),
      );
    } else {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('${couponType.name} 쿠폰을 생성하시겠습니까?'),
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
    return Scaffold(
      body: Column(
        children: [
          const DPAppbar(
            header: '쿠폰 발급',
          ),
          Expanded(
            child: Obx(
              () => switch (controller.couponService.couponTypesState) {
                CouponTypesStateInitial() || CouponTypesStateLoading() || CouponTypesStateFailed() => Center(
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
                            bool confirm = await _showConfirmationDialog(context, e);
                            if (confirm) {
                              Get.toNamed(Routes.COUPON, arguments: e.id);
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
                  style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale800),
                ),
                const SizedBox(width: 8),
                Text('${couponType.amount}원', style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale700)),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorTheme.grayscale500),
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
      child: Text(title, style: textTheme.token.copyWith(color: colorTheme.grayscale500)),
    );
  }
}
