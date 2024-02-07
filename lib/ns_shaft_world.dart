import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:game_failing_down/utility.dart';

class NSShaftWorld extends World with TapCallbacks, HasGameReference {
  NSShaftWorld({
    Random? random,
  }) : _random = random ?? Random();

  final Random _random;
  Size screenSize = const Size(0, 0);
  final double level = 1;
  late double speed = 200 + (level * 200);
  late final double groundLevel = (screenSize.height / 2) - (screenSize.height / 5);

  Size getSize() {
    return screenSize;
  }

  @override
  Future<void> onLoad() async {
    screenSize = Utility.getScreenDensity();
  }
}