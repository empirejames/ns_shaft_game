import 'dart:ui' as UI;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/floors/normal_floor.dart';
import 'package:game_failing_down/components/level_timer.dart';
import 'package:game_failing_down/components/play_area.dart';
import 'package:game_failing_down/components/spikes.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/core/utilities/utilities.dart';
import 'package:game_failing_down/core/utils/utils.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/widget/dialogs/game_lost_dialog.dart';

const _playerSize = Size(60, 100);

enum BunnyState {
  hurt('assets/images/kenney_jumper_pack/PNG/Players/bunny1_hurt.png'),
  walkRight('assets/images/kenney_jumper_pack/PNG/Players/bunny1_walk_right1.png'),
  walkLeft('assets/images/kenney_jumper_pack/PNG/Players/bunny1_walk_left1.png'),
  ready('assets/images/kenney_jumper_pack/PNG/Players/bunny1_ready.png'),
  stand('assets/images/kenney_jumper_pack/PNG/Players/bunny1_stand.png');

  const BunnyState(this.path);

  final String path;

  static String getResFromIndex (int index){
    return BunnyState.values[index].path;
  }

  static String getRes(BunnyState state) {
    for (BunnyState s in BunnyState.values) {
      if (s == state) {
        return s.path;
      }
    }
    return '';
  }
}

class PlayerController extends Component with HasGameReference<NsRunner>, FlameBlocListenable<PlayerBloc, PlayerState> {
  @override
  bool listenWhen(PlayerState previousState, PlayerState newState) {
    return previousState.status != newState.status;
  }

  @override
  void onNewState(PlayerState state) {
    if (state.status == GameStatus.respawn) {
      game.overlays.remove(GameLostDialog.overlayKey);
      game.bloc.add(PlayerStartEvent());
      parent?.addAll([
        game.player = MainCharacter(
          velocity : Vector2(0,0),
          size: Vector2(_playerSize.width, _playerSize.height),
          game: game,
          cornerRadius: const Radius.circular(ballRadius / 2),
          position: Vector2(100, 100),
        ),
        game.levelTimer = LevelTimer(game: game),
      ]);
    }
  }
}

class MainCharacter extends PositionComponent
    with CollisionCallbacks, DragCallbacks, HasGameReference<NsRunner>, FlameBlocListenable<PlayerBloc, PlayerState> {
  MainCharacter({
    required this.velocity,
    required this.cornerRadius,
    required this.game,
    required super.position,
    required super.size,
  }) : super(
    anchor: Anchor.center,
    children: [RectangleHitbox()],
  );

  static const playerSize = _playerSize;
  static final playerVecSize = Vector2(_playerSize.width, _playerSize.height);

  final Radius cornerRadius;

  @override
  final NsRunner game;

  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  bool isStandOnFloor = false;
  double floorPosition = 0.0;
  List<UI.Image> images = [];
  BunnyState? state;
  Direction direction = Direction.none;

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < BunnyState.values.length; i++) {
      images.add(await Utility.loadImage(BunnyState.getResFromIndex(i), _playerSize));
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch(state) {
      case BunnyState.hurt :
        canvas.drawImage(images[0], Offset.zero, _paint);
        break;
      case BunnyState.walkRight :
        canvas.drawImage(images[1], Offset.zero, _paint);
        break;
      case BunnyState.walkLeft :
        canvas.drawImage(images[2], Offset.zero, _paint);
        break;
      case BunnyState.ready :
        canvas.drawImage(images[3], Offset.zero, _paint);
        break;
      case BunnyState.stand :
        canvas.drawImage(images[4], Offset.zero, _paint);
        break;
      default :
        canvas.drawImage(images[4], Offset.zero, _paint);
        break;
    }

    // canvas.drawRRect(
    //     RRect.fromRectAndRadius(
    //       Offset.zero & size.toSize(),
    //       cornerRadius,
    //     ),
    //     _paint);
  }

  @override // Add from here...
  void onCollisionStart(Set<Vector2> rabbits, PositionComponent other) {
    super.onCollisionStart(rabbits, other);
    final rabbit = rabbits.first;

    if (other is PlayArea) {
      if (rabbit.y >= game.height) {
        NsLogger.gameStatus('Game end, because rabbit is out of the screen');
      } else if (rabbit.y <= 0) {
        NsLogger.collision('Touch ceiling, pos: (${rabbit.x}, ${rabbit.y})');
        game.bloc.add(ReduceLifeEvent());
        isStandOnFloor = false;
        state = BunnyState.stand;
      }
    } else if (other is NormalFloor) {
      // FIXME: 要解決從側邊踩進，會有可能踩在空氣地板
      if ((other.topLeft.dy - rabbit.y).abs() < 5 &&
          getIntersectionOverlap(rabbit.x, rabbit.x + playerSize.width, other.topLeft.dx, other.bottomRight.dx) > 10) {
        NsLogger.collision('Touch normal floor, pos: (${rabbit.x}, ${rabbit.y}) (floor: ${other.topLeft}), overlay: ${getIntersectionOverlap(rabbit.x, rabbit.x + playerSize.width, other.topLeft.dx, other.bottomRight.dx)}');
        isStandOnFloor = true;
        state = BunnyState.stand;
        velocity.y = other.velocity.y;
      }
    } else if (other is Spikes) {
      NsLogger.collision('Touch spikes, pos: (${rabbit.x}, ${rabbit.y})');
    } else {
      debugPrint('collision with $other');
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // print('collision with $other');
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is NormalFloor) {
      isStandOnFloor = false;
      velocity.y = 150;
    }
  }

  @override
  void onNewState(PlayerState state) {
    if (state.status == GameStatus.end) {
      game.overlays.add(GameLostDialog.overlayKey);
      game.levelTimer.removeFromParent();
      removeFromParent();
    } else {
      direction = state.direction;
    }
  }

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    switch (direction) {
      case Direction.left:
        moveBy(-batStep);
        break;
      case Direction.right:
        moveBy(batStep);
        break;
      default:
    }
    if (isStandOnFloor) {
      position.y -= velocity.y * dt;
    } else {
      position.y += 300 * dt;
    }

    if (position.y > game.height) {
      game.overlays.add(GameLostDialog.overlayKey);
      game.levelTimer.removeFromParent();
      removeFromParent();
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x)
        .clamp(width / 2, game.width - width / 2);
  }

  void moveBy(double dx) {
    final moveLowerBound = width / 2;
    final moveUpperBound = game.width - width / 2;

    final double dstX = position.x + dx;
    final double resolvedDstX = dstX.clamp(moveLowerBound, moveUpperBound);
    final onEdgeOrOverflow = dstX <= moveLowerBound || dstX >= moveUpperBound;
    double resolvedOffsetX = dx;
    const baseDuration = 0.01;
    double duration = baseDuration;

    if (onEdgeOrOverflow) {
      state = BunnyState.stand;
      resolvedOffsetX = resolvedDstX - position.x;
      duration = (resolvedOffsetX / dx * baseDuration).clamp(0, 999);
    } else {
      state = dx < 0 ? BunnyState.walkLeft : BunnyState.walkRight;
    }

    if (resolvedOffsetX.abs() >= 0 && duration > 0) {
      add(MoveByEffect(
        Vector2(
          resolvedOffsetX,
          0,
        ),
        EffectController(duration: duration),
      ));
    }
  }
}
