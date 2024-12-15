import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DPAnimatedShowUp extends StatefulWidget {
  final Duration wait;
  final Duration duration;
  final Widget child;
  final Curve curve;
  final Offset slideFrom;

  const DPAnimatedShowUp({
    super.key,
    required this.child,
    this.wait = Duration.zero,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOut,
    this.slideFrom = Offset.zero,
  });

  @override
  State<DPAnimatedShowUp> createState() => _DPAnimatedShowUpState();
}

class _DPAnimatedShowUpState extends State<DPAnimatedShowUp> with SingleTickerProviderStateMixin {
  double opacity = 0;

  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: widget.slideFrom,
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  ));

  @override
  void initState() {
    _handleAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleAnimation() async {
    await Future.delayed(widget.wait);
    if (!mounted) {
      return;
    }
    opacity = 1;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedBuilder(
        animation: _offsetAnimation,
        child: widget.child,
        builder: (context, child) => Opacity(
          opacity: _controller.value,
          child: Transform.translate(
            offset: widget.slideFrom * (1 - _controller.value),
            child: child,
          ),
        ),
      ),
    );
  }
}
