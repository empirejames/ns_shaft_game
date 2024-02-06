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
    on<AddLevelEvent>(_addLevel);
    on<ReduceLifeEvent>(_reduceLife);
  }

  _updateDirection(PlayerUpdateDirectionEvent event, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: event.direction));
  }

  _respwan(_, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: Direction.none, status: GameStatus.respawn, level: 1, life: 10));
  }

  _startGame(_, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: Direction.none, status: GameStatus.playing));
  }

  _addLevel(_, Emitter<PlayerState> emit) {
    final newLevel = state.level + 1;
    emit(state.copyWith(level: newLevel));
  }

  _reduceLife(_, Emitter<PlayerState> emit) {
    final life = state.life - 1;
    if (life > 0) {
      emit(state.copyWith(life: life));
    } else {
      emit(state.copyWith(status: GameStatus.end));
    }
  }
}