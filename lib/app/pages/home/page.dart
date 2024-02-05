import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/pay_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/user_info_area.dart';
import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DPColors.grayscale200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logoTitle.svg',
                width: 16,
                height: 16,
              ),
              const Spacer(),
              const Row(
                children: [
                  Icon(Icons.support_agent_rounded, size: 24, color: DPColors.grayscale600),
                  SizedBox(width: 24),
                  Icon(Icons.help_rounded, size: 24, color: DPColors.grayscale600),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
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
              // PayArea()
              // const SizedBox(height: 20),
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   decoration: DPBoxDecorations.box3,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text('내 쿠폰', style: DPTypography.itemTitle(color: DPColors.grayscale900)),
              //           ],
              //         ),
              //       ),
              //       const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: DPColors.grayscale500),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
