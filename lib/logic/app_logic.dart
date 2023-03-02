import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/logic/common/platform_info.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:desktop_window/desktop_window.dart';

class AppLogic {
  bool isBootstrapComplete = false;

  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  Future<void> bootstrap() async {
    debugPrint("bootstrap start...");

    if (PlatformInfo.isDesktop) {
      await DesktopWindow.setMinWindowSize($styles.sizes.minAppSize);
    }

    // TODO: load bitmaps

    if (PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    await settingsLogic.load();

    await localeLogic.load();

    // TODO: load wonders data

    // TODO: load events

    // TODO: load collectibles
    isBootstrapComplete = true;
    bool showIntro = settingsLogic.hasCompletedOnboarding.value == false;
    if (showIntro) {
      appRouter.go(ScreenPaths.intro);
    } else {
      appRouter.go(ScreenPaths.home);
    }
  }
}
