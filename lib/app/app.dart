import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/pages/splash_page.dart';
import 'package:game_failing_down/widget/control_overlay.dart';
import 'package:game_failing_down/widget/dialogs/game_lost_dialog.dart';
import 'package:game_failing_down/widget/info_overlay.dart';

class NsApp extends StatelessWidget {
  const NsApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}
