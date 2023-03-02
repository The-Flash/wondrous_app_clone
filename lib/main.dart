import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/logic/app_logic.dart';
import 'package:wondrous_app_clone/logic/locale_logic.dart';
import 'package:wondrous_app_clone/logic/settings_logic.dart';
import 'package:wondrous_app_clone/ui/app_scaffold.dart';

void main() async {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  registerSingletons();
  runApp(const WondersApp());
  await appLogic.bootstrap();
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

void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());

  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());

  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
}

AppLogic get appLogic => GetIt.I.get<AppLogic>();

SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();

LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();



AppLocalizations get $strings => localeLogic.strings;
AppStyle get $styles => WondersAppScaffold.style;

