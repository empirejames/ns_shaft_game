import 'dart:ui' as UI;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/ns_runner.dart';

import '../config.dart';
import '../utility.dart';
import 'normal_floor.dart';

class Spikes extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {
  Spikes(Vector2 position)
      : super(
          position: position,
          size: Vector2(100, 50),
          anchor: Anchor.bottomCenter,
          children: [RectangleHitbox()],
        );

  UI.Image? image;

  @override
  Future<void> onLoad() async {
    const String spikesBottom = 'assets/images/kenney_jumper_pack/PNG/Environment/nails.png';
    image = await Utility.loadImage(spikesBottom, const Size(100, 50));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xff1e6091)
      ..style = PaintingStyle.fill;
    double part = game.width % 100;
    for (int i = 0; i < part; i++) {
      canvas.drawImage(image!, Offset(i * 100, 80), paint);
    }
  }

  @override
  @mustCallSuper
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
