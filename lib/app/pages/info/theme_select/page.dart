import 'package:dimipay_app_v2/app/pages/info/theme_select/controller.dart';
import 'package:dimipay_app_v2/app/pages/info/theme_select/widget/option_item.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSelectPage extends GetView<ThemeSelectPageController> {
  const ThemeSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DPAnimatedShowUp(
          wait: const Duration(milliseconds: 100),
          slideFrom: const Offset(8, 0),
          child: Column(
            children: [
              const DPAppbar(header: '화면 테마'),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Obx(
                      () => Column(
                        children: [
                          OptionItem(
                            title: '라이트',
                            onTap: () => controller.themeService.changeTheme(ThemeMode.light),
                            selected: controller.themeService.themeMode == ThemeMode.light,
                          ),
                          OptionItem(
                            title: '다크',
                            onTap: () => controller.themeService.changeTheme(ThemeMode.dark),
                            selected: controller.themeService.themeMode == ThemeMode.dark,
                          ),
                          OptionItem(
                            title: '시스템 설정에 맞춰',
                            onTap: () => controller.themeService.changeTheme(ThemeMode.system),
                            selected: controller.themeService.themeMode == ThemeMode.system,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
