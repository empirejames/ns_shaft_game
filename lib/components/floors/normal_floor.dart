import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/components/play_area.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/core/utilities/utilities.dart';
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
    Random? random,
  }) {
    const values = [FloorType.small, FloorType.tall, FloorType.wide];
    final obstacleType = values.random(random);
    switch (obstacleType) {
      case FloorType.small:
        return NormalFloor.small(velocity: velocity, position: position, radius: radius);
      case FloorType.tall:
        return NormalFloor.tall(velocity: velocity, position: position, radius: radius);
      case FloorType.wide:
        return NormalFloor.wide(velocity: velocity, position: position, radius: radius);
    }
  }
  ui.Image? image;
  @override
  Future<void> onLoad() async {
    String imgSrc = "";
    if (width == 100) {
      imgSrc = 'assets/images/kenney_jumper_pack/PNG/Environment/ground_grass.png';
    } else if (width == 130) {
      imgSrc = 'assets/images/kenney_jumper_pack/PNG/Environment/ground_stone.png';
    } else {
      imgSrc = 'assets/images/kenney_jumper_pack/PNG/Environment/ground_wood.png';
    }
    image = await Utility.loadImage(imgSrc,Size(width, height));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawImage(image!, Offset.zero, paint);
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
