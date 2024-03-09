import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/app/app.dart';
import 'package:game_failing_down/pages/game_page.dart';
import 'package:game_failing_down/pages/splash_page.dart';
import 'package:game_failing_down/widget/dialogs/player_name_dialog.dart';
import 'package:go_router/go_router.dart';

import 'bloc/player/player_bloc.dart';
import 'ns_runner.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PlayerNameDialog(),
      routes: [
        GoRoute(
          path: 'play',
          builder: (context, state) {
            // return const GamePage();
            return FutureBuilder(
              future: Flame.device.fullScreen(),
              builder: (_, __) {
                return const GamePage();
              },
            );
          },
        ),
      ],
    ),
  ],
);
