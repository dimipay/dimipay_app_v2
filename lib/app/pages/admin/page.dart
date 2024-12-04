import 'package:dimipay_app_v2/app/pages/admin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/divider.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends GetView<AdminPageController> {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DPAppbar(
            header: '관리자',
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                const _SectionHeader(title: '상품 관리'),
                _MenuItem(
                  title: '상품 가격 동기화',
                  onTap: () => Get.toNamed(Routes.SYNC_PRODUCT),
                ),
                _MenuItem(
                  title: '상품 신청 확인',
                  onTap: () => launchUrl(Uri.parse('https://padlet.com/dimicafe/2024-tevcgyyqgoqxc1zz')),
                ),
                const DPDivider(),
                const _SectionHeader(title: '결제 및 쿠폰'),
                _MenuItem(
                  title: '결제 취소',
                  onTap: () => Get.toNamed(Routes.CANCEL_TRANSACTION),
                ),
                _MenuItem(
                  title: '쿠폰 발급',
                  onTap: () => Get.toNamed(Routes.GENERATE_COUPON),
                ),
                const DPDivider(),
                const _SectionHeader(title: '보안'),
                _MenuItem(
                  title: '사용자 핀 초기화',
                  onTap: () => Get.toNamed(Routes.RESET_PIN),
                ),
                _MenuItem(
                  title: '키오스크 패스코드 생성',
                  onTap: () => Get.toNamed(Routes.GENERATE_PASSCODE),
                ),
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
    required this.title,
    this.onTap,
    // ignore: unused_element
    this.hint,
  });

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
    required this.title,
  });

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
