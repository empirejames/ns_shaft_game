import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/components/play_area.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/ns_runner.dart';

enum FloorType {
  small,
  tall,
  wide,
}

class NormalFloor extends RectangleComponent
    with CollisionCallbacks, HasGameReference<NsRunner> {
  NormalFloor({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            size: Vector2(brickWidth, brickHeight),
            anchor: Anchor.bottomCenter,
            children: [RectangleHitbox()]);

  final Vector2 velocity;
  late Sprite _sprite;

  Offset get topLeft {
    return Offset(position.x - width / 2, position.y - height);
  }

  Offset get bottomRight {
    return Offset(position.x + width / 2, position.y);
  }

  NormalFloor.wide({required this.velocity, super.position, required double radius}) : super(
    size: Vector2(130, 50),
      anchor: Anchor.bottomCenter,
      paint: Paint()
        ..color = const Color(0xfff2e8cf)
        ..style = PaintingStyle.fill,
      children: [RectangleHitbox()]
  );

  NormalFloor.small({required this.velocity, super.position, required double radius}) : super(
    size: Vector2(100, 50),
      anchor: Anchor.bottomCenter,
      paint: Paint()
        ..color = const Color(0xfff2e8cf)
        ..style = PaintingStyle.fill,
      children: [RectangleHitbox()]
  );

  NormalFloor.tall({required this.velocity, super.position, required double radius}) : super(
    size: Vector2(160, 50),
      anchor: Anchor.bottomCenter,
      paint: Paint()
        ..color = const Color(0xfff2e8cf)
        ..style = PaintingStyle.fill,
      children: [RectangleHitbox()]
  );

  factory NormalFloor.random({
    required Vector2? position,
    required double radius,
    required Vector2 velocity,
    required double level,
    Random? random,
  }) {

    const values = [FloorType.small, FloorType.tall, FloorType.wide];
    final obstacleType = values.random(random);
    Vector2 speedLevel = Vector2(velocity.x + level * 20, velocity.y + level * 20);
    switch (obstacleType) {
      case FloorType.small:
        return NormalFloor.small(velocity: speedLevel, position: position, radius: radius);
      case FloorType.tall:
        return NormalFloor.tall(velocity: speedLevel, position: position, radius: radius);
      case FloorType.wide:
        return NormalFloor.wide(velocity: speedLevel, position: position, radius: radius);
    }
  }

  @override
  Future<void> onLoad() async {
    String imgSrc = "";
    if (width == 100) {
      imgSrc = 'kenney_jumper_pack/PNG/Environment/ground_grass.png';
    } else if (width == 130) {
      imgSrc = 'kenney_jumper_pack/PNG/Environment/ground_stone.png';
    } else {
      imgSrc = 'kenney_jumper_pack/PNG/Environment/ground_wood.png';
    }
    final floor = await Flame.images.load(imgSrc);
    _sprite = Sprite(floor);
  }

  @override
  void render(Canvas canvas) {
    // super.render(canvas);
    _sprite.render(canvas, size: size);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= velocity.y * dt;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is PlayArea) {
      if (position.y <= 0) {
        removeFromParent();

      }
    }
  }
}
