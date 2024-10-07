import 'package:dimipay_app_v2/app/pages/info/controller.dart';
import 'package:dimipay_app_v2/app/pages/info/widgets/user_info_area.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/divider.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPage extends GetView<InfoPageController> {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Scaffold(
      backgroundColor: colorTheme.grayscale100,
      body: Column(
        children: [
          const DPAppbar(
            header: '정보',
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                Obx(
                  () => switch (controller.userService.userState) {
                    UserStateInitial() || UserStateLoding() || UserStateFailed() => const UserAreaLoading(),
                    UserStateSuccess(value: final user) => UserAreaSuccess(user: user),
                  },
                ),
                const DPDivider(),
                const _SectionHeader(title: '결제 관리'),
                _MenuItem(
                  title: '결제 내역',
                  onTap: () => Get.toNamed(Routes.TRANSACTION),
                ),
                Obx(() {
                  return _MenuItem(
                    title: '결제 수단',
                    onTap: () => Get.toNamed(Routes.PAYMENT),
                    hint: controller.paymentService.paymentMethodsState is PaymentMethodsStateSuccess ? '${(controller.paymentService.paymentMethodsState as PaymentMethodsStateSuccess).value.length}개' : null,
                  );
                }),
                Obx(() {
                  return _MenuItem(
                    title: 'Face Sign',
                    onTap: () => Get.toNamed(Routes.FACESIGN),
                    hint: controller.faceSignService.isRegistered ? '등록 됨' : '등록 안됨',
                  );
                }),
                _MenuItem(
                  title: '핀 변경',
                  onTap: () => Get.toNamed(Routes.PIN, arguments: {"pinPageType": PinPageType.editPin}),
                ),
                const DPDivider(),
                const _SectionHeader(title: '기타'),
                _MenuItem(
                  title: '화면 테마',
                  onTap: () => Get.toNamed(Routes.THEME_SELECT),
                ),
                _MenuItem(
                  title: '앱 버전',
                  onTap: () => Get.toNamed(Routes.VERSION),
                ),
                const SizedBox(height: 72),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String? hint;
  final void Function()? onTap;

  const _MenuItem({
    Key? key,
    required this.title,
    this.onTap,
    this.hint,
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
              title,
              style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale800),
            ),
            const Spacer(),
            Row(
              children: [
                hint == null ? Container() : Text(hint!, style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale700)),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colorTheme.grayscale500),
              ],
            ),
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
