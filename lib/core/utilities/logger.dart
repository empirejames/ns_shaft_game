import 'package:flutter/widgets.dart';
import '../../config.dart';

class NsLogger {
  NsLogger._();

  static void collision(String message) {
    if (LOG_PLAYER_COLLISION) {
      debugPrint('[💥 Collision] $message');
    }
  }

  static void gameStatus(String message) {
    if (LOG_GAME_STATUS) {
      debugPrint('[🎮 Game Status] $message');
    }
  }

}