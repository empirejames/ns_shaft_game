part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.life = 10,
    this.direction = Direction.none,
    this.status = GameStatus.waiting,
  });

  final int life;

  final Direction direction;

  final GameStatus status;

  PlayerState copyWith({
    Direction? direction,
    int? life,
    GameStatus? status,
  }) {
    return PlayerState(
      direction: direction ?? this.direction,
      life: life ?? this.life,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [ life, direction, status ];
}