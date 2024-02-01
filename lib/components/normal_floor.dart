import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/components/play_area.dart';
import 'package:game_failing_down/ns_runner.dart';

import '../config.dart';

class NormalFloor extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {
  NormalFloor({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            size: Vector2(brickWidth, brickHeight),
            anchor: Anchor.bottomCenter,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
            children: [RectangleHitbox()]);
  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= velocity.y * dt;
  }

  @override // Add from here...
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= game.height ||
          intersectionPoints.first.x >= game.width) {
        removeFromParent();
      }
    } else if (other is MainCharacter) {
      debugPrint('ccccccc ollision with $other');
    } else {
      debugPrint('collision with $other');
    }
  }
}
