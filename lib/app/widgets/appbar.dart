import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DPAppbar extends StatelessWidget {
  final String? header;
  final String? paragraph;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onBackButtonPressed;

  const DPAppbar({
    super.key,
    this.header,
    this.paragraph,
    this.leading,
    this.trailing,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: ColoredBox(
                                color: colorTheme.grayscale100,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 20,
                                  color: colorTheme.grayscale500,
                                ),
                              ),
                            ),
                      if (trailing != null) trailing!,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (header != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            header!,
                            style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
                          ),
                        ),
                      if (paragraph != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            paragraph!,
                            style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
