import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/ui/app_scaffold.dart';
import 'package:wondrous_app_clone/ui/screens/home/wonders_home_screen.dart';
import 'package:wondrous_app_clone/ui/screens/intro/intro_screen.dart';

class ScreenPaths {
  static String splash = "/";
  static String intro = "/welcome";
  static String home = "/home";
  static String settings = "/settings";
  static String wonderDetails(WonderType type, {int tabIndex = 0}) => '/wonder/${type.name}?t=$tabIndex';
}

final appRouter = GoRouter(
  redirect: _handleRedirect,
  navigatorBuilder: (_, __, child) => WondersAppScaffold(
    child: child,
  ),
  routes: [
    AppRoute(
      ScreenPaths.splash,
      (_) => Container(
        color: $styles.colors.greyStrong,
      ),
    ),
    AppRoute(
      ScreenPaths.home,
      (_) => const HomeScreen(),
    ),
    AppRoute(
      ScreenPaths.intro,
      (_) => const IntroScreen(),
    ),
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

String? _handleRedirect(GoRouterState state) {
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint("Navigate to: ${state.location}");
  return null;
}
