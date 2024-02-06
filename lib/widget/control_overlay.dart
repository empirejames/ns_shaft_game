import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/ns_shaft_world.dart';

class ControlOverlay extends StatefulWidget {
  const ControlOverlay({
    super.key,
  });

  @override
  State<ControlOverlay> createState() => _ControlOverlayState();
}

class _ControlOverlayState extends State<ControlOverlay> {
  bool shouldStopLeft = false;
  bool shouldStopRight = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 30,
          left: 50,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) {
              context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.left));
              shouldStopLeft = true;
              shouldStopRight = false;
            },
            onTapUp: (_) {
              if (shouldStopLeft) {
                shouldStopLeft = false;
                context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.none));
              }
            },
            child: Icon(
              Icons.arrow_left,
              color: Colors.white,
              size: 100,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 50,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) {
              context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.right));
              shouldStopRight = true;
              shouldStopLeft = false;
            },
            onTapUp: (_) {
              if (shouldStopRight) {
                context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.none));
                shouldStopRight = false;
              }
            },
            child: Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 100,
            ),
          ),
        ),
      ],
    );
  }
}