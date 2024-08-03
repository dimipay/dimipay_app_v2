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
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
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
              const _SectionHeader(title: '사용자 관리'),
              _MenuItem(
                title: '핀번호 초기화',
                onTap: () => {},
              ),
              const DPDivider(),
              const _SectionHeader(title: '쿠폰 관리'),
              _MenuItem(
                title: '쿠폰 발급하기',
                onTap: () => Get.toNamed(Routes.CREATE_COUPON),
              ),
              _MenuItem(
                title: '활성화된 쿠폰',
                onTap: () => {},
              ),
              const DPDivider(),
              const _SectionHeader(title: '키오스크 관리'),
              _MenuItem(
                title: '키오스크 목록',
                onTap: () => {},
              ),
              _MenuItem(
                title: '키오스크 핀번호 생성',
                onTap: () => {},
              ),
              const DPDivider(),
              const _SectionHeader(title: '기타'),
              _MenuItem(
                title: '상품 신청 확인하기',
                onTap: () => launchUrl(Uri.parse(
                    'https://padlet.com/dimicafe/2024-tevcgyyqgoqxc1zz')),
              ),
            ],
          ))
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
              style:
                  textTheme.itemTitle.copyWith(color: colorTheme.grayscale800),
            ),
            const Spacer(),
            Row(
              children: [
                hint == null
                    ? Container()
                    : Text(hint!,
                        style: textTheme.paragraph2
                            .copyWith(color: colorTheme.grayscale700)),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: colorTheme.grayscale500),
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
      child: Text(title,
          style: textTheme.token.copyWith(color: colorTheme.grayscale500)),
    );
  }
}
