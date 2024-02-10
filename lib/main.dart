import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/widget/control_overlay.dart';
import 'package:game_failing_down/widget/dialogs/game_lost_dialog.dart';
import 'package:game_failing_down/widget/info_overlay.dart';

import 'ns_runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  final PlayerBloc playerBloc = PlayerBloc();
  NsRunner nsGame = NsRunner(bloc: playerBloc);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: playerBloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              GameWidget(
                game: nsGame,
                overlayBuilderMap: {
                  GameLostDialog.overlayKey: (BuildContext context, NsRunner game) {
                    return GameLostDialog(game);
                  },
                },
              ),
              const SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 80),
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
