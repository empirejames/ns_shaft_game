import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/ns_runner.dart';


class PlayArea extends RectangleComponent with HasGameReference<NsRunner> {
  PlayArea() : super(
    paint: Paint()..color = const Color(0xfff2e8cf),
    children: [ RectangleHitbox() ],
  );

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // this.size.setValues(size.x, size.y);
    print(this.size);
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}