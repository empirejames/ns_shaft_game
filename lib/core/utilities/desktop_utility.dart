import 'package:flutter/material.dart';
import 'package:game_failing_down/config.dart';
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

    await windowManager.ensureInitialized();
    const initSize = Size(gameWidth, gameHeight);

    // TODO: size 可以根據螢幕寬高限制 max
    WindowOptions windowOptions = WindowOptions(
      size: initSize,
      minimumSize: initSize / 2,
      maximumSize: initSize,
      // center: true,
      // backgroundColor: Colors.transparent,
      // skipTaskbar: false,
      // titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.setAspectRatio(gameWidth / gameHeight);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // await windowManager.setTitleBarStyle(
      //   TitleBarStyle.hidden,
      //   windowButtonVisibility: false,
      // );
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
