import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class DPGestureDetectorWithOpacityInteraction extends StatefulWidget {
  final void Function()? onTap;
  final Widget child;
  const DPGestureDetectorWithOpacityInteraction({super.key, this.onTap, required this.child});

  @override
  State<DPGestureDetectorWithOpacityInteraction> createState() => _DPGestureDetectorWithOpacityInteractionState();
}

class _DPGestureDetectorWithOpacityInteractionState extends State<DPGestureDetectorWithOpacityInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: pressUp,
      child: Listener(
        onPointerDown: (_) => pressDown(),
        onPointerUp: (_) => pressUp(),
        child: Container(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            opacity: isPressed ? 0.6 : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class DPButton extends StatefulWidget {
  final void Function()? onTap;
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
  State<DPButton> createState() => _DPButtonState();
}

class _DPButtonState extends State<DPButton> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return AnimatedScale(
      scale: isPressed ? 0.97 : 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapCancel: pressUp,
        child: Listener(
          onPointerDown: (event) => pressDown(),
          onPointerUp: (event) => pressUp(),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: DPGestureDetectorWithOpacityInteraction(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? colorTheme.primaryBrand,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: widget.border,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: DefaultTextStyle.merge(
                      style: textTheme.itemDescription.copyWith(color: widget.foregroundColor ?? Colors.white),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
