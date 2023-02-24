import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wondrous_app_clone/common_libs.dart';

class ScreenPaths {
  static String splash = "/";
  static String intro = "/welcome";
  static String home = "/home";
  static String settings = "/settings";
}

final appRouter = GoRouter(
  redirect: _handleRedirect,
  routes: [
    AppRoute(
      ScreenPaths.splash,
      (_) => Container(
        color: $styles.colors.greyStrong,
      ),
    )
  ],
);

class AppRoute extends GoRoute {
  final bool useFade;

  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    this.useFade = false,
  }) : super(
            path: path,
            routes: routes,
            pageBuilder: (context, state) {
              final pageContent = Scaffold(
                body: builder(state),
                resizeToAvoidBottomInset: false,
              );
              if (useFade) {
                return CustomTransitionPage(
                    key: state.pageKey,
                    child: pageContent,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    });
              }
              return CupertinoPage(child: pageContent);
            });
}

String? _handleRedirect(BuildContext context, GoRouterState state) {
  debugPrint("Navigate to: ${state.location}");
  return ScreenPaths.splash;
}
