import 'package:flutter/material.dart';

class AppScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return RawScrollbar(
      controller: details.controller,
      child: child,
    );
  }
}
