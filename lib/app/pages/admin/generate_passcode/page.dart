import 'dart:io';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/model.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneratePasscodePage extends GetView<GeneratePasscodePageController> {
  const GeneratePasscodePage({super.key});

  Future<bool> _showConfirmationDialog(BuildContext context, Kiosk kiosk) async {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    if (Platform.isIOS) {
      return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text('${kiosk.name} 패스코드를 생성하시겠습니까?'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Get.back(result: false),
              child: Text('취소', style: textTheme.paragraph1.copyWith(color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () => Get.back(result: true),
              child: Text('생성', style: textTheme.paragraph1.copyWith(color: Colors.blue)),
            ),
          ],
        ),
      );
    } else {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('${kiosk.name} 패스코드를 생성하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('생성'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Scaffold(
      body: Column(
        children: [
          const DPAppbar(
            header: '키오스크 패스코드 생성하기',
          ),
          Expanded(
            child: Obx(
              () => switch (controller.kioskService.kiosksState) {
                KiosksStateInitial() || KiosksStateLoading() || KiosksStateFailed() => Center(
                      child: CircularProgressIndicator(
                    color: colorTheme.primaryBrand,
                  )),
                KiosksStateSuccess(value: final kiosks) => ListView(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const _SectionHeader(title: '키오스크 목록'),
                      ...kiosks
                          .map(
                            (e) => _KioskItem(
                              kiosk: e,
                              onTap: () async {
                                bool confirm = await _showConfirmationDialog(context, e);
                                if (confirm) {
                                  Get.toNamed(Routes.PASSCODE, arguments: e.id);
                                }
                              },
                            ),
                          )
                          .toList(),
                    ],
                  )
              },
            ),
          )
        ],
      ),
    );
  }
}

class _KioskItem extends StatelessWidget {
  final Kiosk kiosk;
  final void Function()? onTap;

  const _KioskItem({
    Key? key,
    required this.kiosk,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return DPGestureDetectorWithFillInteraction(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Text(
              kiosk.name,
              style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale800),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorTheme.grayscale500),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(title, style: textTheme.token.copyWith(color: colorTheme.grayscale500)),
    );
  }
}
