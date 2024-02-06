import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/widget/control_overlay.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/game_lost_dialog.dart';
import 'package:game_failing_down/utility.dart';
import 'package:game_failing_down/widget/info_overlay.dart';

import 'ns_runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Size size = Utility.getScreenDensity();
  final PlayerBloc bloc = PlayerBloc();
  NsRunner nsGame = NsRunner(screenSize: size, bloc: bloc);
  runApp(
    BlocProvider.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              GameWidget(
                game: nsGame,
                overlayBuilderMap: {
                  "GG": (BuildContext context, NsRunner game) {
                    return GameLostDialog(game);
                  },
                },
              ),
              SafeArea(
                child: Stack(
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InfoOverlay(),
                      ],
                    ),
                    ControlOverlay(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
