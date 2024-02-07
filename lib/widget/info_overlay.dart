import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';

import '../config.dart';

class InfoOverlay extends StatelessWidget {
  const InfoOverlay({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(width: 10,),
        LifeCounter(),
        Expanded(child: SizedBox()),
        LevelCounter(),
        SizedBox(width: 10,),
      ],
    );
  }
}

class LifeCounter extends StatelessWidget {
  const LifeCounter({super.key});

  List<Widget> _build(int count) {
    return List.generate(
        gameLife, (index) => Container(
        width: 15,
        height: 25,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: index < count ? Colors.red : Colors.transparent,
          border: Border.all(
            color: Colors.grey,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(50)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PlayerBloc, PlayerState, int>(
      selector: (state) => state.life,
      builder: (context, count) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "HP : ", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 25
            )),
            ..._build(count),
          ],
        );
      },
    );
  }
}

class LevelCounter extends StatelessWidget {
  const LevelCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PlayerBloc, PlayerState, int>(
      selector: (state) => state.level, 
      builder: (context, level) {
        return Text(
          'Level $level',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            fontSize: 25
          ),
        );
      }
    );
  }
}