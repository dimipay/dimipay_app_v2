import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/admin_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/pay_area.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/suggest_product.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/user_info_area.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_crossfade.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
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
                  DPGestureDetectorWithOpacityInteraction(
                    onTap: () => controller.openKakaoChannelTalk(),
                    child: Icon(Icons.support_agent_rounded,
                        size: 24, color: colorTheme.grayscale600),
                  ),
                  const SizedBox(width: 24),
                  DPGestureDetectorWithOpacityInteraction(
                    onTap: () => Get.toNamed(Routes.MANUAL),
                    child: Icon(Icons.help_rounded,
                        size: 24, color: colorTheme.grayscale600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          const SizedBox(height: 20),
          Obx(
            () => DPAnimatedCrossFade(
              firstChildBuilder: () => const UserInfoAreaLoading(),
              secondChildBuilder: () => UserInfoArea(
                  user: (controller.userService.userState as UserStateSuccess)
                      .value),
              crossFadeState:
                  controller.userService.userState is! UserStateSuccess
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 100),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => AnimatedCrossFade(
              firstChild: const PayAreaLoading(),
              secondChild: const PayArea(),
              crossFadeState: controller.paymentService.paymentMethodsState
                      is! PaymentMethodsStateSuccess
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 100),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => DPAnimatedCrossFade(
              firstChildBuilder: () => const SuggestProductAreaLoading(),
              secondChildBuilder: () {
                final userState = controller.userService.userState;
                if (userState is UserStateSuccess) {
                  return userState.value.role == 'A'
                      ? const AdminArea()
                      : const SuggestProductArea();
                }
                return const SuggestProductArea();
              },
              crossFadeState:
                  controller.userService.userState is! UserStateSuccess
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 100),
            ),
          ),
        ],
      ),
    );
  }
}
