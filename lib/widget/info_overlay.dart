import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';

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
      10, (index) => Container(
        width: 10,
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: index < count ? Colors.blue : Colors.transparent,
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
            fontSize: 28
          ),
        );
      }
    );
  }
}