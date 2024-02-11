import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/widget/control_overlay.dart';
import 'package:game_failing_down/widget/dialogs/game_lost_dialog.dart';
import 'package:game_failing_down/widget/info_overlay.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.nsGame,
  });

  final NsRunner nsGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
