part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {}

class PlayerUpdateDirectionEvent extends PlayerEvent {
  PlayerUpdateDirectionEvent(this.direction);

  final Direction direction;

  @override
  List<Object?> get props => [ direction ];
}
