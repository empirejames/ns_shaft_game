import 'dart:io';

import 'package:flutter/foundation.dart';

class MyPlatformUtility {
  MyPlatformUtility._();

  // NOTES:
  // `Platform` 不可以在 Web 下使用，會報錯

  static bool get isWindows {
    if (kIsWeb) {
      return false;
    }
    return Platform.isWindows;
  }

  static bool get isMacOS {
    if (kIsWeb) {
      return false;
    }
    return Platform.isMacOS;
  }

  static bool get isAndroid {
    if (kIsWeb) {
      return false;
    }
    return Platform.isAndroid;
  }

  static bool get isIOS {
    if (kIsWeb) {
      return false;
    }
    return Platform.isIOS;
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    }
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  static bool get isMobile {
    if (kIsWeb) {
      return false;
    }
    return Platform.isAndroid || Platform.isIOS;
  }
}
