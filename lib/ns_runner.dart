import 'dart:async';
import 'dart:async' as async_pkg;
import 'dart:math' as math;
import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/garbage.dart';
import 'package:game_failing_down/components/level_timer.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/components/spikes.dart';
import 'package:game_failing_down/ns_shaft_world.dart';

import 'components/floors/normal_floor.dart';
import 'components/play_area.dart';
import 'config.dart';

class NsRunner extends FlameGame<NSShaftWorld>
    with HasCollisionDetection, KeyboardEvents {

  NsRunner({
    required this.bloc,
  }) : super(world: NSShaftWorld());

  late double tileSize;
  final PlayerBloc bloc;

  Size get getScreenSize => world.screenSize;

  // flame components
  late MainCharacter player;
  late LevelTimer levelTimer;
  late PlayArea _playArea;
  late async_pkg.Timer createFloorTimer;

  createComponent(NSShaftWorld world) {
    createFloorTimer = async_pkg.Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      double level = 100;
      double x = math.Random().nextDouble() * world.screenSize.width;
      double y = world.screenSize.height;
      world.add(
        NormalFloor.random(
          radius: ballRadius,
          position: Vector2(x, y),
          velocity: Vector2(level, level).normalized()
            ..scale(height / 4),
          level: bloc.state.level.toDouble(),
          random: Random(),
        ),
      );
    });
  }

  createGarbage(NSShaftWorld world) {
    createFloorTimer =
        async_pkg.Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      double level = 100;
      double x = math.Random().nextDouble() * world.screenSize.width;
      double y = world.screenSize.height;
      world.add(Garbage(
          position: Vector2(x, y),
          velocity: Vector2(level, level).normalized()..scale(height / 4),
          radius: ballRadius));
    });
  }

  initFloor () {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      double level = 100;
      Vector2 position = Vector2(world.screenSize.width / 2, world.screenSize.height);
      Vector2 speed = Vector2(level, level);
      world.add(NormalFloor.small(
          radius: ballRadius,
          position: position,
          velocity: speed.normalized()
            ..scale(height / 4)));
    });
  }

  // Add this variable
  double get width => size.x;
  double get height => size.y;

  void isStartGame(bool isStart) {
    if (isStart) {
      createComponent(world);
    } else {
      createFloorTimer.cancel();
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    camera = CameraComponent(
      world: world,
      viewfinder: Viewfinder()..anchor = Anchor.topLeft,
      viewport: FixedAspectRatioViewport(aspectRatio: gameWidth / gameHeight),
    );
    _playArea = PlayArea();
    world.add(_playArea);
    world.add(Spikes(Vector2(0, 0)));
    initFloor();
    createComponent(world);
    createGarbage(world);

    await world.add(
      FlameBlocProvider<PlayerBloc, PlayerState>.value(
        value: bloc,
        children: [
          player = MainCharacter(
            velocity : Vector2(0,0),
            size: MainCharacter.playerVecSize,
            game: this,
            cornerRadius: const Radius.circular(ballRadius / 2),
            position: Vector2(width / 2, height * 0.1),
          ),
          PlayerController(),
          levelTimer = LevelTimer(game: this),
        ],
      ),
    );
    debugMode = false;
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    // final playerBloc = world.children.query<FlameBlocProvider<PlayerBloc, PlayerState>>().firstOrNull;
    // if (playerBloc == null) {
    //   return KeyEventResult.skipRemainingHandlers;
    // }

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        player.moveBy(-batStep);
        break;
      case LogicalKeyboardKey.arrowRight:
        player.moveBy(batStep);
        break;
      default:
        return KeyEventResult.skipRemainingHandlers;
    }

    return KeyEventResult.handled;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }

  void resize(Size size) {
    print('======= $size');
    world.screenSize = size;
    camera.viewport = FixedSizeViewport(size.width, size.height);
    _playArea.size = Vector2(size.width, size.height);
    tileSize = world.screenSize.width / 9;
  }
}
