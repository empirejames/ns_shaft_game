import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/ns_runner.dart';

import '../config.dart';

class Garbage extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {

  Garbage({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
    size: Vector2(545, 790) * 0.05,
    anchor: Anchor.center,
    children: [RectangleHitbox()],
  );

  late Sprite _sprite;
  final Vector2 velocity;

  @override
  Future<void> onLoad() async {
    final floor = await Flame.images.load('others/apple.png');
    _sprite = Sprite(floor);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= velocity.y * dt;
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is MainCharacter) {
      removeFromParent();
      game.bloc.add(CollectGarbageEvent());
    }
  }
}