import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoArea extends GetView<HomePageController> {
  final User user;
  const UserInfoArea({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPGestureDetectorWithScaleInteraction(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.grayscale100,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale300,
            width: 1,
          )),
        ),
        child: DPGestureDetectorWithOpacityInteraction(
          onTap: () {
            Get.toNamed(Routes.INFO);
            controller.resetBrightness();
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 21,
                  backgroundColor: colorTheme.grayscale200,
                  backgroundImage: NetworkImage(user.profileImage),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale900)),
                      Text('결제 내역, 내 결제 수단 관리', style: textTheme.token.copyWith(color: colorTheme.grayscale600)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorTheme.grayscale500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoAreaLoading extends StatelessWidget {
  const UserInfoAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Shimmer.fromColors(
      baseColor: colorTheme.grayscale300,
      highlightColor: colorTheme.grayscale200,
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.grayscale100,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale300,
            width: 1,
          )),
        ),
        height: 84,
      ),
    );
  }
}
