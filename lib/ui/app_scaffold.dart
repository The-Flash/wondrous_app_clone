import 'package:flutter/material.dart';

import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget {
  const WondersAppScaffold({super.key, required this.child});

  final Widget child;
  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: Theme(
        data: $styles.colors.toThemeData(),
        child: DefaultTextStyle(
          style: $styles.text.body,
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}
