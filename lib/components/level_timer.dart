import 'package:flame/components.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/config.dart';
import 'package:game_failing_down/ns_runner.dart';


class LevelTimer extends TimerComponent {
  LevelTimer({
    required this.game,
  }) : super(period: periodSpeedUpTime, repeat: true);

  final NsRunner game;

  @override
  void onTick() {
    game.bloc.add(AddLevelEvent());
    super.onTick();
  }
}