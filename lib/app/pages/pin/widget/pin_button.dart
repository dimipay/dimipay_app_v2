import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:flutter/material.dart';

class PinButton extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final void Function()? onTap;
  const PinButton({required this.child, super.key, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DPButton(
        isTapEffectEnabled: false,
        radius: BorderRadius.circular(16),
        onTap: enabled ? onTap : null,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
