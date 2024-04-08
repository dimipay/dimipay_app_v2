import 'package:dimipay_app_v2/app/pages/version/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VersionPage extends GetView<VersionPageController> {
  const VersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '앱 버전'),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/appicon.svg',
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '디미페이',
                    style: textTheme.header2
                        .copyWith(color: colorTheme.grayscale800),
                  ),
                  const Spacer(),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                '앱 버전 ${controller.appVersion.value}',
                                style: textTheme.paragraph1
                                    .copyWith(color: colorTheme.grayscale600),
                              )),
                              const SizedBox(height: 8),
                              DPButton(
                                isTapEffectEnabled: false,
                                onTap: () => Get.toNamed(Routes.LICENSE),
                                child: Text(
                                  '오픈소스 라이선스 보기',
                                  style: textTheme.paragraph1Underlined
                                      .copyWith(color: colorTheme.grayscale600),
                                ),
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}