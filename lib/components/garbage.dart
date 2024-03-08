import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/ns_runner.dart';

import '../config.dart';

class Garbage extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {


  final Vector2 velocity;
  Garbage({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
    size: Vector2(brickWidth, brickHeight),
    anchor: Anchor.center,
    paint: Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill,
    children: [RectangleHitbox()],
  );

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= velocity.y * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is MainCharacter) {
      removeFromParent();
      game.bloc.add(AddGarbageEvent());
    }
  }
}