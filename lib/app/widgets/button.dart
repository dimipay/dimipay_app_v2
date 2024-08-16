import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class DPGestureDetectorWithFillInteraction extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Duration duration;
  final Widget child;
  final EdgeInsets effectPadding;
  final double effectBorderRadius;
  const DPGestureDetectorWithFillInteraction({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.effectPadding = EdgeInsets.zero,
    this.effectBorderRadius = 0,
  });

  @override
  State<DPGestureDetectorWithFillInteraction> createState() => _DPGestureDetectorWithFillInteractionState();
}

class _DPGestureDetectorWithFillInteractionState extends State<DPGestureDetectorWithFillInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapCancel: pressUp,
      child: Listener(
        onPointerDown: (_) => pressDown(),
        onPointerUp: (_) => pressUp(),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: isPressed ? 0.05 : 0,
                  duration: widget.duration,
                  child: Container(
                    margin: widget.effectPadding,
                    decoration: BoxDecoration(
                      color: colorTheme.grayscale1000,
                      borderRadius: BorderRadius.circular(widget.effectBorderRadius),
                    ),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}

class DPGestureDetectorWithOpacityInteraction extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Duration duration;
  final Widget child;
  const DPGestureDetectorWithOpacityInteraction({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<DPGestureDetectorWithOpacityInteraction> createState() => _DPGestureDetectorWithOpacityInteractionState();
}

class _DPGestureDetectorWithOpacityInteractionState extends State<DPGestureDetectorWithOpacityInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null && widget.onLongPress == null) {
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
      onLongPress: widget.onLongPress,
      onTapCancel: pressUp,
      child: Listener(
        onPointerDown: (_) => pressDown(),
        onPointerUp: (_) => pressUp(),
        child: Container(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: widget.duration,
            curve: Curves.easeOut,
            opacity: isPressed ? 0.6 : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class DPGestureDetectorWithScaleInteraction extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Duration duration;
  final Widget child;
  const DPGestureDetectorWithScaleInteraction({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<DPGestureDetectorWithScaleInteraction> createState() => _DPGestureDetectorWithScaleInteractionState();
}

class _DPGestureDetectorWithScaleInteractionState extends State<DPGestureDetectorWithScaleInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed ? 0.97 : 1,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapCancel: pressUp,
        child: Listener(
          onPointerDown: (_) => pressDown(),
          onPointerUp: (_) => pressUp(),
          child: widget.child,
        ),
      ),
    );
  }
}

class DPButton extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BoxBorder? border;

  const DPButton({
    super.key,
    this.onTap,
    this.onLongPress,
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
        onLongPress = null,
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
        onLongPress = null,
        backgroundColor = backgroundColor ?? DPLightThemeColors().primaryBrand.withAlpha(100),
        foregroundColor = foregroundColor ?? Colors.white.withAlpha(120);

  @override
  State<DPButton> createState() => _DPButtonState();
}

class _DPButtonState extends State<DPButton> {
  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return DPGestureDetectorWithScaleInteraction(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: DPGestureDetectorWithOpacityInteraction(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
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
    );
  }
}