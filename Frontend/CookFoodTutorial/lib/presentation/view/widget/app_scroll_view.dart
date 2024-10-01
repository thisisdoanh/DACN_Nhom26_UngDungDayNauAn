import 'package:flutter/material.dart';

import '../../../common/utils/disable_glow_behavior.dart';

class AppScrollView extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const AppScrollView({
    super.key,
    required this.child,
    this.padding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: padding ?? EdgeInsets.zero,
        physics: physics ?? const ClampingScrollPhysics(),
        child: child,
      ),
    );
  }
}
