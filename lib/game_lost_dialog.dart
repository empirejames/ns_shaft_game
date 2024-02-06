import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/ns_runner.dart';

import 'bloc/player/player_bloc.dart';
class GameLostDialog extends StatelessWidget {

  final NsRunner game;
  const GameLostDialog(this.game, {
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 250,

        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'You completed level ${1} in 10 seconds.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            TextButton (
              onPressed: () {
                context.read<PlayerBloc>().add(PlayerRespwanEvent());
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(80, 50),
                backgroundColor: Colors.amberAccent,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text("Play again",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
