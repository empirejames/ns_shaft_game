import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/ns_runner.dart';

import '../config.dart';
import 'floors/normal_floor.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {

  Brick(Vector2 position, Color color) : super(
    position: position,
    size: Vector2(brickWidth, brickHeight),
    anchor: Anchor.center,
    paint: Paint()
      ..color = color
      ..style = PaintingStyle.fill,
    children: [RectangleHitbox()],
  );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();

    if (game.world.children.query<Brick>().length == 1) {
      game.world.removeAll(game.world.children.query<NormalFloor>());
      game.world.removeAll(game.world.children.query<MainCharacter>());
    }
  }
}