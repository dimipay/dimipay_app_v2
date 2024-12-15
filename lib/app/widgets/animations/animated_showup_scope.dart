import 'package:dimipay_app_v2/app/widgets/animations/animated_showup.dart';
import 'package:flutter/widgets.dart';

class DPAnimatedShowUpScope extends StatefulWidget {
  final Duration wait;
  final Duration duration;
  final Duration waitBetweenChildren;
  final Curve curve;
  final Offset slideFrom;
  final Widget child;
  const DPAnimatedShowUpScope({
    super.key,
    required this.child,
    this.wait = Duration.zero,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOut,
    this.slideFrom = Offset.zero,
    this.waitBetweenChildren = Duration.zero,
  });

  @override
  State<DPAnimatedShowUpScope> createState() => _DPAnimatedShowUpScopeState();
}

class _DPAnimatedShowUpScopeState extends State<DPAnimatedShowUpScope> {
  final List<Key> _itemKeys = [];

  int getItemIndex(DPAnimatedShowUpScopeItem item) {
    return _itemKeys.indexOf(item.key!);
  }

  void registerItem(DPAnimatedShowUpScopeItem item) {
    _itemKeys.add(item.key!);
  }

  void unregisterItem(DPAnimatedShowUpScopeItem item) {
    _itemKeys.remove(item.key!);
  }

  @override
  Widget build(BuildContext context) {
    _itemKeys.clear();
    return widget.child;
  }
}

class DPAnimatedShowUpScopeItem extends StatefulWidget {
  final Widget child;
  DPAnimatedShowUpScopeItem({Key? key, required this.child}) : super(key: key ?? UniqueKey());

  @override
  State<DPAnimatedShowUpScopeItem> createState() => _DPAnimatedShowUpScopeItemState();
}

class _DPAnimatedShowUpScopeItemState extends State<DPAnimatedShowUpScopeItem> {
  late _DPAnimatedShowUpScopeState parent;
  bool isNewItem = false;

  @override
  void initState() {
    parent = context.findAncestorStateOfType<_DPAnimatedShowUpScopeState>()!;
    parent.registerItem(widget);
    super.initState();
  }

  @override
  void dispose() {
    parent.unregisterItem(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DPAnimatedShowUp(
      curve: parent.widget.curve,
      duration: parent.widget.duration,
      slideFrom: parent.widget.slideFrom,
      wait: Duration(milliseconds: parent.getItemIndex(widget) * parent.widget.waitBetweenChildren.inMilliseconds + parent.widget.wait.inMilliseconds),
      child: widget.child,
    );
  }
}
