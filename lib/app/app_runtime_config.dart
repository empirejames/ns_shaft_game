import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/core/utilities/my_platform_utility.dart';
import 'package:window_manager/window_manager.dart';

class AppRuntimeConfig {
  AppRuntimeConfig._();
  static final AppRuntimeConfig _instance = AppRuntimeConfig._();
  static AppRuntimeConfig get instance => _instance;

  void init(BuildContext context) {
    final isDesktop = MyPlatformUtility.isDesktop;
    if (isDesktop) {
      WidgetsBinding.instance.platformDispatcher.onMetricsChanged = () {
        // final view = WidgetsBinding.instance.platformDispatcher.views.first;
        // final screenSize = view.physicalSize / view.devicePixelRatio;
        // const ratio = gameWidth / gameHeight;
        // // 強制維持固定比例縮放
        // final useBaseWidth = screenSize.width >= screenSize.height * ratio;
        //
        // Size resolvedSize = Size(
        //   useBaseWidth ? screenSize.width : screenSize.height * ratio,
        //   useBaseWidth ? screenSize.width / ratio : screenSize.height
        // );
        //
        // windowManager.setSize(resolvedSize);
        // WindowOptions windowOptions = WindowOptions(
        //   size: resolvedSize
        // );
        // windowManager.waitUntilReadyToShow(windowOptions, () async {
        //   await windowManager.show();
        //   await windowManager.focus();
        // });

      };
    }
  }

}