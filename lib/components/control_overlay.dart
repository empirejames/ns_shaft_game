import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_failing_down/components/main_character.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/ns_shaft_world.dart';

class ControlOverlay extends StatefulWidget {
  const ControlOverlay({
    super.key,
    required this.world,
  });

  final NSShaftWorld world;

  @override
  State<ControlOverlay> createState() => _ControlOverlayState();
}

class _ControlOverlayState extends State<ControlOverlay> {
  Timer? controlTimer;
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
              if (controlTimer == null) {
                shouldStopLeft = true;
                controlTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
                  widget.world.children.query<MainCharacter>().first.moveBy(-batStep);
                });
              }
            },
            onTapUp: (_) {
              if (shouldStopLeft) {
                shouldStopLeft = false;
                controlTimer?.cancel();
                controlTimer = null;
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
              if (controlTimer == null) {
                shouldStopRight = true;
                controlTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
                  widget.world.children.query<MainCharacter>().first.moveBy(batStep);
                });
              }
            },
            onTapUp: (_) {
              if (shouldStopRight) {
                shouldStopRight = false;
                controlTimer?.cancel();
                controlTimer = null;
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