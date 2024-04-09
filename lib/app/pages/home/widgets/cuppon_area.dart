import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CupponArea extends GetView<HomePageController> {
  const CupponArea({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;

    return DPButton(
      onTap: () => DPErrorSnackBar().open("쿠폰 기능은 아직 준비 중이에요!"),
      radius: BorderRadius.circular(16),
      decoration: BoxDecoration(
        color: colorTheme.grayscale100,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.fromBorderSide(BorderSide(
          color: colorTheme.grayscale300,
          width: 1,
        )),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('내 쿠폰',
                      style: textTheme.itemTitle
                          .copyWith(color: colorTheme.grayscale900)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: colorTheme.grayscale500),
          ],
        ),
      ),
    );
  }
}

class CupponAreaLoading extends StatelessWidget {
  const CupponAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Shimmer.fromColors(
      baseColor: colorTheme.grayscale300,
      highlightColor: colorTheme.grayscale200,
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.grayscale100,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.fromBorderSide(BorderSide(
            color: colorTheme.grayscale300,
            width: 1,
          )),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 16,
                    color: colorTheme.grayscale200,
                  ),
                ],
              ),
            ),
            Container(
              width: 16,
              height: 16,
              color: colorTheme.grayscale200,
            ),
          ],
        ),
      ),
    );
  }
}
