import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';

class ControlOverlay extends StatefulWidget {
  const ControlOverlay({
    super.key,
  });

  @override
  State<ControlOverlay> createState() => _ControlOverlayState();
}

class _ControlOverlayState extends State<ControlOverlay> {
  bool _shouldStopLeft = false;
  bool _shouldStopRight = false;

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
              _shouldStopLeft = true;
              _shouldStopRight = false;
            },
            onTapUp: (_) {
              if (_shouldStopLeft) {
                _shouldStopLeft = false;
                context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.none));
              }
            },
            child: const Icon(
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
              _shouldStopRight = true;
              _shouldStopLeft = false;
            },
            onTapUp: (_) {
              if (_shouldStopRight) {
                context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.none));
                _shouldStopRight = false;
              }
            },
            child: const Icon(
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