import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';

class InfoOverlay extends StatelessWidget {
  const InfoOverlay({super.key});
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previous, current) => previous.life != current.life,
      builder: (context, state) {
        return LifeCounter(state.life);
      }
    );
  }
}

class LifeCounter extends StatelessWidget {
  const LifeCounter(this.count, {super.key});

  final int count;

  List<Widget> _build() {
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 10,),
        ..._build(),
      ],
    );
  }
}