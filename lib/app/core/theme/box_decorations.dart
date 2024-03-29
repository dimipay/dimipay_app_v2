import 'package:dimipay_design_kit/dimipay_design_kit.dart';
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

  static BoxDecoration box1_1 = const BoxDecoration(
    color: DPColors.grayscale200,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale300,
      width: 1,
    )),
  );

  static BoxDecoration box2 = const BoxDecoration(
    color: DPColors.primaryBrand,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.primaryBrand,
      width: 1,
    )),
  );

  static BoxDecoration box2_1 = const BoxDecoration(
    color: DPColors.primaryBrand,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.primaryBrand,
      width: 1,
    )),
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

  static BoxDecoration box5 = const BoxDecoration(
    color: DPColors.grayscale200,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.grayscale300,
      width: 1,
    )),
  );

  static BoxDecoration accordion1 = const BoxDecoration(
    color: DPColors.grayscale200,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(BorderSide(
      color: DPColors.primaryBrand,
      width: 2,
    )),
  );

  static InputDecoration inputDecoration(
      {String? labelText, String? hintText, required bool isFocused}) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
      filled: true,
      fillColor: isFocused ? DPColors.grayscale100 : DPColors.grayscale200,
      counterText: "",
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: DPColors.grayscale300,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: DPColors.primaryBrand,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: labelText,
      labelStyle: DPTypography.itemDescription(color: DPColors.grayscale500),
      hintText: hintText,
      hintStyle: DPTypography.description(color: DPColors.grayscale600),
    );
  }
}
