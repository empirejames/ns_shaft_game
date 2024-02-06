part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.life = 10,
    this.direction = Direction.none,
  });

  final int life;

  final Direction direction;

  PlayerState copyWith({
    Direction? direction,
    int? life,
  }) {
    return PlayerState(
      direction: direction ?? this.direction,
      life: life ?? this.life,
    );
  }

  @override
  List<Object?> get props => [ life, direction ];
}