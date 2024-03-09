import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/core/utilities/my_platform_utility.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/widget/control_overlay.dart';
import 'package:game_failing_down/widget/dialogs/game_lost_dialog.dart';
import 'package:game_failing_down/widget/info_overlay.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
  });

  // final NsRunner nsGame;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with WidgetsBindingObserver { // with WidgetsBindingObserver
  NsRunner? _nsGame;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.platformDispatcher.onMetricsChanged = () {
      if (MyPlatformUtility.isDesktop) {
        _updateSize();
      }
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<PlayerBloc>();
      _nsGame = NsRunner(bloc: bloc);
      _updateSize();
    });
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
      _nsGame?.isStartGame(false);
    } else if (state == AppLifecycleState.resumed) {
      _nsGame?.isStartGame(true);
    }
  }

  void _updateSize() {
    if (MyPlatformUtility.isDesktop) {
      final view = View.of(context);
      final screenSize = view.physicalSize / view.devicePixelRatio;
      _nsGame?.resize(screenSize);
    } else {
      final screenSize = MediaQuery.of(context).size;
      _nsGame?.resize(screenSize);
    }

    if (mounted) {
      setState(() { });
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
    if (_nsGame == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: GameWidget(
              game: _nsGame!,
              overlayBuilderMap: {
                GameLostDialog.overlayKey: (BuildContext context, NsRunner game) {
                  return GameLostDialog(game);
                },
              },
            ),
          ),
          const Positioned.fill(
            child: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 80),
                      InfoOverlay(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: ControlOverlay(),
          ),
        ],
      ),
    );
  }
}
