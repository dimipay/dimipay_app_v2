import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:flutter/material.dart';

abstract class DPBoxDecorations {
  static BoxDecoration box1 = const BoxDecoration(
    color: DPColors.grayscale200,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale300,
      width: 1,
    )),
  );

  static BoxDecoration box2 = const BoxDecoration(
    color: DPColors.primaryBrand,
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static BoxDecoration box3 = const BoxDecoration(
    color: DPColors.grayscale100,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale300,
      width: 1,
    )),
  );

  static BoxDecoration box4 = const BoxDecoration(
    color: DPColors.grayscale200,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale300,
      width: 2,
    )),
  );

  static BoxDecoration accordion1 = const BoxDecoration(
    color: DPColors.grayscale100,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.primaryBrand,
      width: 2,
    )),
  );
}
