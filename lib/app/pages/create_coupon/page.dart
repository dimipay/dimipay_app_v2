import 'package:dimipay_app_v2/app/pages/create_coupon/controller.dart';
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
              child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: DPButton(
                  onTap: () => {},
                  child: const Text('쿠폰 발급하기'),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
