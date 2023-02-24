import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/ui/app_scaffold.dart';

void main() {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  runApp(const WondersApp());
  FlutterNativeSplash.remove();
}

class WondersApp extends StatelessWidget {
  const WondersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.routerDelegate,
      theme: ThemeData(
        fontFamily: $styles.text.body.fontFamily,
      ),
    );
  }
}

AppStyle get $styles => WondersAppScaffold.style;
