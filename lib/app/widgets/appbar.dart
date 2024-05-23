import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPAppbar extends StatelessWidget {
  final String? header;
  final String? paragraph;
  final Widget? leading;

  const DPAppbar({super.key, required this.header, this.paragraph, this.leading});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading != null
                ? leading!
                : DPButton(
                    onTap: () => Get.back(),
                    radius: BorderRadius.circular(20),
                    isTapEffectEnabled: false,
                    child: Icon(Icons.arrow_back_ios_rounded, size: 20, color: colorTheme.grayscale500),
                  ),
            if (header != null)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    header!,
                    style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
                  ),
                ],
              ),
            if (paragraph != null)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    paragraph!,
                    style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
