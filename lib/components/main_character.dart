import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/components/normal_floor.dart';
import 'package:game_failing_down/components/play_area.dart';
import 'package:game_failing_down/ns_runner.dart';

class MainCharacter extends PositionComponent
    with CollisionCallbacks, DragCallbacks, HasGameReference<NsRunner> {
  MainCharacter({
    required this.velocity,
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  final Radius cornerRadius;

  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  bool isStandOnFloor = false;
  double floorPosition = 0.0;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size.toSize(),
          cornerRadius,
        ),
        _paint);
  }

  @override // Add from here...
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {


      if (intersectionPoints.first.y <= game.height ||
          intersectionPoints.first.x >= game.width) {
        if (intersectionPoints.first.x <= 0 || intersectionPoints.first.x >= game.width) {
          print("AAAAA");
        } else {
          //debugPrint('removeFromParent');
          //removeFromParent();
        }
      } else {
        print("End The Game");
      }
    } else if (other is NormalFloor) {
      isStandOnFloor = true;
      velocity.y = other.velocity.y;
      debugPrint('gggg collision with $other');
    } else {
      //debugPrint('collision with $positionComponent');
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is NormalFloor) {
      isStandOnFloor = false;
      velocity.y = 150;
    }
  }

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    if (isStandOnFloor) {
      position.y -= velocity.y * dt;
    } else {
      position.y += 100 * dt;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x)
        .clamp(width / 2, game.width - width / 2);
  }

  void moveBy(double dx) {
    add(MoveToEffect(
      Vector2(
        (position.x + dx).clamp(width / 2, game.width - width / 2),
        position.y,
      ),
      EffectController(duration: 0.1),
    ));
  }
}
