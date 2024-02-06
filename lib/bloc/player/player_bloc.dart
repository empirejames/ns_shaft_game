import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_event.dart';
part 'player_state.dart';

enum Direction {
  left, right, none
}

enum GameStatus {
  playing, waiting, end, respawn,
}

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerUpdateDirectionEvent>(_updateDirection);
    on<PlayerRespwanEvent>(_respwan);
    on<PlayerStartEvent>(_startGame);
  }

  _updateDirection(PlayerUpdateDirectionEvent event, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: event.direction));
  }

  _respwan(_, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: Direction.none, status: GameStatus.respawn));
  }

  _startGame(_, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: Direction.none, status: GameStatus.playing));
  }
}