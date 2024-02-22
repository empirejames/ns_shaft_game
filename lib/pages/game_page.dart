import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_failing_down/core/utilities/my_platform_utility.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/widget/control_overlay.dart';
import 'package:game_failing_down/widget/dialogs/game_lost_dialog.dart';
import 'package:game_failing_down/widget/dialogs/player_name_dialog.dart';
import 'package:game_failing_down/widget/info_overlay.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.nsGame,
  });

  final NsRunner nsGame;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with WidgetsBindingObserver { // with WidgetsBindingObserver
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.platformDispatcher.onMetricsChanged = () {
      if (MyPlatformUtility.isDesktop) {
        final view = View.of(context);
        final screenSize = view.physicalSize / view.devicePixelRatio;
        widget.nsGame.resize(screenSize);
        setState(() { });
      }
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      widget.nsGame.isStartGame(false);
    } else if (state == AppLifecycleState.resumed) {
      widget.nsGame.isStartGame(true);
    }
  }

  // @override
  // void didChangeMetrics() {
  //   super.didChangeMetrics();
  //   setState(() {
  //     if (MyPlatformUtility.isDesktop) {
  //       final view = View.of(context);
  //       final screenSize = view.physicalSize / view.devicePixelRatio;
  //       widget.nsGame.resize(screenSize);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: GameWidget(
              game: widget.nsGame,
              overlayBuilderMap: {
                GameLostDialog.overlayKey: (BuildContext context, NsRunner game) {
                  return GameLostDialog(game);
                },
              },
            ),
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
