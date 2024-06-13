import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPAppbar extends StatelessWidget {
  final String? header;
  final String? paragraph;
  final Widget? leading;
  final void Function()? onBackButtonPressed;

  const DPAppbar({super.key, this.header, this.paragraph, this.leading, this.onBackButtonPressed});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading != null
                ? leading!
                : DPGestureDetectorWithOpacityInteraction(
                    onTap: () {
                      if (onBackButtonPressed != null) {
                        onBackButtonPressed!.call();
                      } else {
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      color: colorTheme.grayscale100,
                      child: Icon(Icons.arrow_back_ios_rounded, size: 20, color: colorTheme.grayscale500),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  if (header != null)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          header!,
                          style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
