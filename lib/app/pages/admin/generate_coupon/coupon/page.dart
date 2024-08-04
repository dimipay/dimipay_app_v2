import 'package:barcode_widget/barcode_widget.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CouponPage extends GetView<CouponPageController> {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(
              header: '쿠폰이 발급되었어요!',
            ),
            const Spacer(flex: 1),
            Obx(() {
              final coupon = controller.couponService.coupon;
              if (coupon == null) {
                return Center(
                  child: CircularProgressIndicator(
                    color: colorTheme.primaryBrand,
                  ),
                );
              }
              return Column(
                children: [
                  CouponWidget(coupon: coupon),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '화면을 찍어가세요!',
                    style: textTheme.header2
                        .copyWith(color: colorTheme.grayscale600),
                  ),
                ],
              );
            }),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class CouponWidget extends StatelessWidget {
  final Coupon coupon;

  const CouponWidget({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorTheme.grayscale200,
          border: Border.all(color: colorTheme.grayscale300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  coupon.name,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
