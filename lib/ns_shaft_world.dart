import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class NSShaftWorld extends World with TapCallbacks, HasGameReference {
  NSShaftWorld(this.screenSize, {
    Random? random,
  }) : _random = random ?? Random();

  final Random _random;
  final Size screenSize;
  final double level = 1;
  late double speed = 200 + (level * 200);
  late final double groundLevel = (screenSize.height / 2) - (screenSize.height / 5);

  Size getSize() {
    return screenSize;
  }

  @override
  Future<void> onLoad() async {

  }
}