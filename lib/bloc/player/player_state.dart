part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.life = 10,
    this.direction = Direction.none,
    this.status = GameStatus.waiting,
    this.level = 1,
  });

  final int life;

  final Direction direction;

  final GameStatus status;

  final int level;

  PlayerState copyWith({
    Direction? direction,
    int? life,
    GameStatus? status,
    int? level,
  }) {
    return PlayerState(
      direction: direction ?? this.direction,
      life: life ?? this.life,
      status: status ?? this.status,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [ life, direction, status, level ];
}