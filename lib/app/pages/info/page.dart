import 'package:dimipay_app_v2/app/pages/info/controller.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/divider.dart';
import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPage extends GetView<InfoPageController> {
  const InfoPage({super.key});

  Widget _profileImageLoading() {
    return const CircleAvatar(
      radius: 21,
      backgroundColor: DPColors.grayscale200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DPColors.grayscale100,
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '정보'),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  controller.userService.obx(
                    (state) => CircleAvatar(
                      radius: 21,
                      backgroundImage: NetworkImage(state!.profileImage),
                    ),
                    onLoading: _profileImageLoading(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(controller.userService.user == null ? 'loading...' : controller.userService.user!.name, style: DPTypography.itemTitle(color: DPColors.grayscale800)),
                        ),
                        Obx(
                          () => Text(controller.userService.user == null ? 'loading...' : controller.userService.user!.accountName, style: DPTypography.token(color: DPColors.grayscale500)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  LogOutButton(onTap: controller.logout),
                ],
              ),
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
                hint: controller.paymentService.paymentMethods == null ? null : '${controller.paymentService.paymentMethods!.length}개',
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
            const _MenuItem(title: '앱 버전'),
            const _MenuItem(title: '이용 약관 및 정책'),
          ],
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  final void Function()? onTap;
  const LogOutButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.logout_rounded, size: 16, color: DPColors.grayscale500),
        onPressed: onTap,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Text(
              title,
              style: DPTypography.itemTitle(color: DPColors.grayscale800),
            ),
            const Spacer(),
            Row(
              children: [
                hint == null ? Container() : Text(hint!, style: DPTypography.paragraph2(color: DPColors.grayscale700)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: DPColors.grayscale500),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(title, style: DPTypography.token(color: DPColors.grayscale500)),
    );
  }
}
