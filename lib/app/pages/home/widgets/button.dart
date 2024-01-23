import 'package:flutter/material.dart';

class DPButton extends StatelessWidget {
  final VoidCallback onTap;
  final BorderRadius? radius;
  final Decoration? decoration;
  final Widget child;
  final bool isTapEffectEnabled;

  const DPButton({
    Key? key,
    required this.onTap,
    this.radius,
    this.decoration,
    required this.child,
    this.isTapEffectEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: isTapEffectEnabled
          ? InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: Ink(
                decoration: decoration,
                child: child,
              ),
            )
          : GestureDetector(
              onTap: onTap,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: decoration,
                  child: child,
                ),
              ),
            ),
    );
  }
}
