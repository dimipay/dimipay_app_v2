import 'package:dimipay_app_v2/app/pages/admin/create_coupon/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCouponPage extends GetView<CreateCouponPageController> {
  const CreateCouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: Column(
        children: [
          const DPAppbar(
            header: '쿠폰 발급하기',
          ),
          Expanded(
            child: Obx(() {
              // Obx를 사용하여 반응형으로 만듭니다.
              final couponTypes = controller.couponService.couponTypes;
              if (couponTypes == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: colorTheme.primaryBrand,
                ));
              }
              return ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [
                  const _SectionHeader(title: '쿠폰 종류'),
                  ...couponTypes
                      .map((e) => _CouponTypeItem(
                            couponType: e,
                            onTap: () => {},
                          ))
                      .toList(),
                ],
              );
            }),
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
    Key? key,
    required this.couponType,
    this.onTap,
  }) : super(key: key);

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
    Key? key,
    required this.title,
  }) : super(key: key);

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
