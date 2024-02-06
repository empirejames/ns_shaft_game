import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
class GameLostDialog extends StatelessWidget {
  const GameLostDialog({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 420,
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Well done!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You completed level ${1} in 10 seconds.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () {
                print("press........ PPPPPP");
              },
              child: const Text('Level selection'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                print('11');
                context.read<PlayerBloc>().add(PlayerRespwanEvent());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Retry'),
                  SizedBox(width: 10,),
                  Icon(
                    Icons.refresh,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
