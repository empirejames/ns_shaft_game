part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {}

class PlayerUpdateDirectionEvent extends PlayerEvent {
  PlayerUpdateDirectionEvent(this.direction);

  final Direction direction;

  @override
  List<Object?> get props => [ direction ];
}

class PlayerRespwanEvent extends PlayerEvent {
  @override
  List<Object?> get props => [];
}

class PlayerStartEvent extends PlayerEvent {
  @override
  List<Object?> get props => [];
}

class AddLevelEvent extends PlayerEvent {
  @override
  List<Object?> get props => [];
}

class ReduceLifeEvent extends PlayerEvent {
  @override
  List<Object?> get props => [];
}