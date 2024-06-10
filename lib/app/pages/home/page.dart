import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/apply_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/pay_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/user_info_area.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;

    return Scaffold(
      backgroundColor: colorTheme.grayscale200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/logoTitle.svg',
                width: 16,
                height: 16,
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.openKakaoChannelTalk(),
                    child: Icon(Icons.support_agent_rounded, size: 24, color: colorTheme.grayscale600),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.ONBOARDING),
                    child: Icon(Icons.help_rounded, size: 24, color: colorTheme.grayscale600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 20),
                    Obx(
                      () => AnimatedCrossFade(
                        firstChild: const UserInfoAreaLoading(),
                        secondChild: const UserInfoArea(),
                        crossFadeState: controller.userService.user == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 100),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => AnimatedCrossFade(
                        firstChild: const PayAreaLoading(),
                        secondChild: const PayArea(),
                        crossFadeState: controller.paymentService.paymentMethods == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 100),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => AnimatedCrossFade(
                        firstChild: const ApplyAreaLoading(),
                        secondChild: const ApplyArea(),
                        crossFadeState: controller.paymentService.paymentMethods == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 100),
                      ),
                    ),
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
