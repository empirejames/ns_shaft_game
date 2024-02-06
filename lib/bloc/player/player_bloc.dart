import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_event.dart';
part 'player_state.dart';

enum Direction {
  left, right, none
}

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerUpdateDirectionEvent>(_updateDirection);
  }

  _updateDirection(PlayerUpdateDirectionEvent event, Emitter<PlayerState> emit) {
    emit(state.copyWith(direction: event.direction));
  }
}