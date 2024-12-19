import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/network/service.dart';

class AdminArea extends GetView<HomePageController> {
  const AdminArea({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    NetworkService networkService = Get.find<NetworkService>();

    return Obx(() {
      final isOffline = !networkService.isOnline;

      return DPGestureDetectorWithScaleInteraction(
        onTap: () => {},
        child: DPGestureDetectorWithOpacityInteraction(
            onTap: isOffline
                ? null
                : () {
              Get.toNamed(Routes.ADMIN);
            },
            child:Opacity(
              opacity: isOffline ? 0.5 : 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: colorTheme.grayscale100,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: colorTheme.grayscale300,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '관리자 페이지',
                              style: textTheme.itemTitle
                                  .copyWith(color: colorTheme.grayscale900),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: colorTheme.grayscale500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      );
    });
  }
}
