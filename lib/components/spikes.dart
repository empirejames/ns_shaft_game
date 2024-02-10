import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/others/asset_path.dart';

/// 51x87 is raw image size
const _displayImageSize = Size(51 / 2, 87 / 2);

class Spikes extends RectangleComponent with CollisionCallbacks, HasGameReference<NsRunner> {
  Spikes(Vector2 position)
      : super(
          position: position,
          size: Vector2(95, 53),
          anchor: Anchor.bottomCenter,
          children: [RectangleHitbox()],
        );

  late Sprite _sprite;

  @override
  Future<void> onLoad() async {
    final floor = await Flame.images.load(AssetPaths.spike_bottom);
    _sprite = Sprite(floor);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    double part = game.width ~/ _displayImageSize.width + game.width % 100;
    for (int i = 0; i < part; i++) {
      _sprite.render(
        canvas,
        size: Vector2(_displayImageSize.width, _displayImageSize.height),
        position: Vector2(i * _displayImageSize.width, 60),
      );
    }
  }

  @override
  @mustCallSuper
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
