import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:flutter/material.dart';

abstract class DPBoxDecorations {
  static BoxDecoration container1 = const BoxDecoration(
    color: DPColors.grayscale100,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale300,
      width: 1,
    )),
  );
  static BoxDecoration container2 = const BoxDecoration(
    color: DPColors.grayscale100,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale400,
      width: 1,
    )),
  );
  static BoxDecoration container3 = const BoxDecoration(
    color: DPColors.grayscale200,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale400,
      width: 1,
    )),
  );
  static BoxDecoration circle = const BoxDecoration(
    color: DPColors.grayscale100,
    borderRadius: BorderRadius.all(Radius.circular(500)),
  );
}
