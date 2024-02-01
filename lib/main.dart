import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/utility.dart';

import 'ns_runner.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Size size = Utility.getScreenDensity();
  NsRunner nsGame = NsRunner(screenSize : size);
  runApp(GameWidget(game: nsGame));
}
