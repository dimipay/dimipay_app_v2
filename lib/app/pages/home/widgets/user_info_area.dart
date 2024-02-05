import 'package:dimipay_app_v2/app/core/theme/box_decorations.dart';
import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoArea extends GetView<HomePageController> {
  const UserInfoArea({super.key});

  @override
  Widget build(BuildContext context) {
    return DPButton(
      onTap: () => Get.toNamed(Routes.INFO),
      decoration: DPBoxDecorations.box3,
      radius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            controller.userService.obx(
              (state) => CircleAvatar(
                radius: 21,
                backgroundColor: DPColors.grayscale200,
                backgroundImage: NetworkImage(state!.profileImage),
              ),
              onLoading: const CircleAvatar(
                radius: 21,
                backgroundColor: DPColors.grayscale200,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(controller.userService.user == null ? 'loading...' : controller.userService.user!.name, style: DPTypography.itemTitle(color: DPColors.grayscale900)),
                  ),
                  Text('내 결제수단, Face Sign 관리', style: DPTypography.token(color: DPColors.grayscale600)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: DPColors.grayscale500),
          ],
        ),
      ),
    );
  }
}

class UserInfoAreaLoading extends StatelessWidget {
  const UserInfoAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DPColors.grayscale300,
      highlightColor: DPColors.grayscale200,
      child: Container(
        decoration: DPBoxDecorations.box3,
        height: 84,
      ),
    );
  }
}
