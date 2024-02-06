import 'dart:ui' as UI;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/level_timer.dart';
import 'package:game_failing_down/components/normal_floor.dart';
import 'package:game_failing_down/components/play_area.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:image/image.dart' as img;


enum BunnyState {
  hurt('assets/images/kenney_jumper_pack/PNG/Players/bunny1_hurt.png'),
  walkRight('assets/images/kenney_jumper_pack/PNG/Players/bunny1_walk_right1.png'),
  walkLeft('assets/images/kenney_jumper_pack/PNG/Players/bunny1_walk_left1.png'),
  ready('assets/images/kenney_jumper_pack/PNG/Players/bunny1_ready.png'),
  stand('assets/images/kenney_jumper_pack/PNG/Players/bunny1_stand.png');

  final String path;

  const BunnyState(this.path);
  
  static String getResFromIndex (int index){
    return BunnyState.values[index].path;
  }

  static String getRes(BunnyState state) {
    for (BunnyState s in BunnyState.values) {
      if (s == state) {
        return s.path;
      }
    }
    return "";
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
      game.overlays.remove('GG');
      game.bloc.add(PlayerStartEvent());
      parent?.addAll([
        game.player =  MainCharacter(
          velocity : Vector2(0,0),
          size: Vector2(60, 100),
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

  final Radius cornerRadius;

  final NsRunner game;

  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  bool isStandOnFloor = false;
  double floorPosition = 0.0;
  List<UI.Image> images = [];
  BunnyState? state;

  Direction direction = Direction.none;



  Future<UI.Image> loadImage(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes = data.buffer.asUint8List();
    img.Image? image = img.decodePng(bytes.buffer.asUint8List());
    img.Image? resized = img.copyResize(image!, width: 60, height: 100);
    Uint8List resizedByteData = img.encodePng(resized);
    return await decodeImageFromList(resizedByteData);
  }

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < BunnyState.values.length; i++) {
      images.add(await loadImage(BunnyState.getResFromIndex(i)));
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
      if (other.position.y - intersectionPoints.first.y > 40) {
        isStandOnFloor = true;
        state = BunnyState.stand;
        velocity.y = other.velocity.y;
      }

      debugPrint('gggg collision with ${other.absolutePosition}');
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

  @override
  void onNewState(PlayerState state) {
    direction = state.direction;
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

    if (position.y > game.screenSize.height) {
      game.overlays.add('GG');
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
    if(dx < 0) {
      state = BunnyState.walkLeft;
    } else {
      state = BunnyState.walkRight;
    }
    add(MoveToEffect(
      Vector2(
        (position.x + dx).clamp(width / 2, game.width - width / 2),
        position.y,
      ),
      EffectController(duration: 0.1),
    ));
  }
}
