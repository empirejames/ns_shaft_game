import 'dart:ui' as UI;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/ns_runner.dart';

import '../config.dart';
import '../utility.dart';
import 'normal_floor.dart';

class Spikes extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {
  Spikes(Vector2 position)
      : super(
          position: position,
          size: Vector2(brickWidth, brickHeight),
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  UI.Image? image;

  @override
  Future<void> onLoad() async {
    const String spikesBottom = 'assets/images/kenney_jumper_pack/PNG/Environment/nails.png';
    image = await Utility.loadImage(spikesBottom, Size(100, 50));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xff1e6091)
      ..style = PaintingStyle.fill;
    double divid = game.width % 100;
    for (int i = 0; i < divid; i++) {
      canvas.drawImage(image!, Offset(i * 100, 0), paint);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // reduce life
  }
}
