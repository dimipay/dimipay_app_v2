import 'package:flutter/material.dart';

class PinButton extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final void Function()? onTap;
  const PinButton({required this.child, super.key, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          color: Colors.white,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
