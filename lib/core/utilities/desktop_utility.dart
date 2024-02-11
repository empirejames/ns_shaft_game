import 'package:flutter/material.dart';
import 'package:game_failing_down/core/utilities/utilities.dart';
import 'package:window_manager/window_manager.dart';

class DesktopUtility {
  DesktopUtility._();

  static bool get isDesktop {
    return MyPlatformUtility.isDesktop;
  }

  static Future<void> init() async {
    if (!isDesktop) {
      return;
    }

    // await windowManager.ensureInitialized();
    // WindowOptions windowOptions = const WindowOptions(
    //   size: Size(900, 680),
    //   minimumSize: Size(450, 680),
    //   center: true,
    //   backgroundColor: Colors.transparent,
    //   skipTaskbar: false,
    //   titleBarStyle: TitleBarStyle.hidden,
    // );
    // windowManager.waitUntilReadyToShow(windowOptions, () async {
    //   await windowManager.setTitleBarStyle(
    //     TitleBarStyle.hidden,
    //     windowButtonVisibility: false,
    //   );
    //   await windowManager.show();
    //   await windowManager.focus();
    // });
  }
}
