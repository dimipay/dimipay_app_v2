import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class DPButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BoxBorder? border;

  const DPButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.border,
    this.foregroundColor,
    required this.child,
  });

  DPButton.loading({
    super.key,
    this.backgroundColor,
    this.border,
    this.foregroundColor,
  })  : onTap = null,
        child = SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: foregroundColor ?? Colors.white, strokeWidth: 2),
        );

  DPButton.disabled({
    super.key,
    Color? backgroundColor,
    Color? foregroundColor,
    this.border,
    required this.child,
  })  : onTap = null,
        backgroundColor = backgroundColor ?? DPLightThemeColors().primaryBrand.withAlpha(100),
        foregroundColor = foregroundColor ?? Colors.white.withAlpha(120);

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? colorTheme.primaryBrand,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: border,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DefaultTextStyle.merge(
                style: textTheme.itemDescription.copyWith(color: foregroundColor ?? Colors.white),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
