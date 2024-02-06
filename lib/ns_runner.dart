import 'dart:async';
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/brick.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/ns_shaft_world.dart';

import 'components/normal_floor.dart';
import 'components/play_area.dart';
import 'config.dart';
import 'dart:async' as Time;

class NsRunner extends FlameGame<NSShaftWorld>
    with HasCollisionDetection, KeyboardEvents {
  late Size screenSize;
  late double tileSize;

  final PlayerBloc bloc;

  NsRunner({required this.screenSize, required this.bloc,})
      : super(
          world: NSShaftWorld(screenSize),
          camera: CameraComponent.withFixedResolution(
              width: screenSize.width, height: screenSize.height),
        );

  createComponent(World world) {
    Time.Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      double level = 100;
      double x = math.Random().nextDouble() * screenSize.width;
      double y = screenSize.height;
      Vector2 position = Vector2(x, y);
      Vector2 speed = Vector2(level, level);
      world.add(NormalFloor.random(
          radius: ballRadius,
          position: position,
          velocity: speed.normalized()
            ..scale(height / 4), random: Random()));
    });
  }

  initFloor() {
    double level = 100;
    Vector2 position = Vector2(screenSize.width / 2, screenSize.height);
    Vector2 speed = Vector2(level, level);
    world.add(NormalFloor(
        radius: ballRadius,
        position: position,
        velocity: speed.normalized()
          ..scale(height / 4)));
  }



  // Add this variable
  double get width => size.x;

  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlayArea());
    initFloor();
    createComponent(world);
    await world.add(
      FlameBlocProvider<PlayerBloc, PlayerState>.value(
        value: bloc,
        children: [
          MainCharacter(
            velocity : Vector2(0,0),
            size: Vector2(60, 100),
            game: this,
            cornerRadius: const Radius.circular(ballRadius / 2),
            position: Vector2(width / 2, height * 0.1),
          ),
        ],
      ),
    );
    // world.add(MainCharacter(
    //     velocity : Vector2(0,0),
    //     size: Vector2(60, 100),
    //     game: this,
    //     cornerRadius: const Radius.circular(ballRadius / 2),
    //     position: Vector2(width / 2, height * 0.1))); // To here
    overlays.add(controlOverlay);
    overlays.add(infoOverlay);
    debugMode = true;
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      world.children.query<MainCharacter>().first.moveBy(-batStep);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      world.children.query<MainCharacter>().first.moveBy(batStep);
    }

    return KeyEventResult.handled;
  }

  Component creakBrick(world) {
    Random random = Random();
    double randHeight = screenSize.height;
    double randWidth = random.nextDouble() * screenSize.width;

    return Brick(
      Vector2(
        brickWidth + brickGutter,
        brickHeight + brickGutter,
      ),
      Colors.black,
    );
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }
}
