import 'package:dimipay_app_v2/app/pages/info/fingerprint/controller.dart';
import 'package:dimipay_app_v2/app/services/fingerprint/state.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FingerprintManagePage extends GetView<FingerprintManagePageController> {
  const FingerprintManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DPAppbar(header: '등록 지문 관리'),
            Expanded(
              child: Obx(
                () => switch (controller.fingerprintService.fingerprintsState) {
                  FingerprintsStateInitial() ||
                  FingerprintsStateLoading() =>
                    Center(
                      child: CircularProgressIndicator(
                          color: colorTheme.primaryBrand),
                    ),
                  FingerprintsStateFailed() =>
                    _RetryArea(onTap: controller.fetchFingerprints),
                  FingerprintsStateSuccess(value: final fingerprints) =>
                    fingerprints.isEmpty
                        ? _EmptyArea(
                            textTheme: textTheme, colorTheme: colorTheme)
                        : ListView(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              _SectionHeader(
                                  title: '등록된 지문 ${fingerprints.length}개'),
                              ...fingerprints.map(
                                (fingerprint) => _FingerprintItem(
                                  name: fingerprint.name,
                                  isDeleting:
                                      controller.isDeleting(fingerprint.name),
                                  onDelete: () => controller
                                      .deleteFingerprint(fingerprint.name),
                                ),
                              ),
                            ],
                          ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FingerprintItem extends StatelessWidget {
  final String name;
  final bool isDeleting;
  final void Function()? onDelete;

  const _FingerprintItem({
    required this.name,
    required this.isDeleting,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style:
                  textTheme.itemTitle.copyWith(color: colorTheme.grayscale800),
            ),
          ),
          isDeleting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorTheme.primaryBrand,
                  ),
                )
              : DPGestureDetectorWithOpacityInteraction(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                    color: colorTheme.primaryNegative,
                  ),
                ),
        ],
      ),
    );
  }
}

class _EmptyArea extends StatelessWidget {
  final DPTypography textTheme;
  final DPColors colorTheme;

  const _EmptyArea({
    required this.textTheme,
    required this.colorTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '등록된 지문이 없어요.',
        style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale600),
      ),
    );
  }
}

class _RetryArea extends StatelessWidget {
  final void Function()? onTap;

  const _RetryArea({this.onTap});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return Center(
      child: DPGestureDetectorWithOpacityInteraction(
        onTap: onTap,
        child: Text(
          '다시 시도',
          style: textTheme.paragraph1Underlined
              .copyWith(color: colorTheme.primaryBrand),
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
      child: Text(
        title,
        style: textTheme.token.copyWith(color: colorTheme.grayscale500),
      ),
    );
  }
}
