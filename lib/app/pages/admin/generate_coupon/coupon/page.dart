import 'package:barcode_widget/barcode_widget.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponPage extends GetView<CouponPageController> {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(
              header: '쿠폰',
            ),
            const Spacer(flex: 1),
            Obx(
              () => switch (controller.couponService.couponState) {
                CouponStateInitial() ||
                CouponStateLoading() ||
                CouponStateFailed() =>
                  Center(
                    child: CircularProgressIndicator(
                      color: colorTheme.primaryBrand,
                    ),
                  ),
                CouponStateSuccess(value: final coupons) => Center(
                    child: SizedBox(
                      height: 300,
                      child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: coupons
                                .asMap()
                                .entries
                                .map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 64, vertical: 8),
                                    child: RepaintBoundary(
                                      key: controller
                                          .getCouponKey(entry.value.code),
                                      // 쿠폰별 key 필요
                                      child: CouponWidget(
                                          coupon: entry.value,
                                          index: entry.key),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
              },
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DPButton(
                onTap: controller.saveToGallery,
                child: const Text('저장하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CouponWidget extends GetView<CouponPageController> {
  final Coupon coupon;
  final int index;

  const CouponWidget({super.key, required this.coupon, required this.index});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorTheme.grayscale200,
        border: Border.all(color: colorTheme.grayscale300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${coupon.name} $index',
                style: textTheme.itemTitle
                    .copyWith(color: colorTheme.grayscale1000),
              ),
              Text(
                '${coupon.amount}원',
                style: textTheme.description
                    .copyWith(color: colorTheme.grayscale600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: colorTheme.grayscale300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: coupon.code,
                  drawText: false,
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: DPLightThemeColors().grayscale200,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    coupon.code,
                    style: textTheme.token
                        .copyWith(color: DPLightThemeColors().grayscale800),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            DateFormat('유효기간: yyyy년 M월 d일')
                .format(DateTime.parse(coupon.expiresAt)),
            style: textTheme.token.copyWith(color: colorTheme.grayscale600),
          )
        ],
      ),
    );
  }
}
