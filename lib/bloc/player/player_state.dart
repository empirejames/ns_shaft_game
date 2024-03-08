part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.life = gameLife,
    this.garbage = gameGarbage,
    this.direction = Direction.none,
    this.status = GameStatus.waiting,
    this.level = 1,
  });

  final int life;

  final int garbage;

  final Direction direction;

  final GameStatus status;

  final int level;

  PlayerState copyWith({
    Direction? direction,
    int? life,
    int? garbage,
    GameStatus? status,
    int? level,
  }) {
    return PlayerState(
      garbage: garbage ?? this.garbage,
      direction: direction ?? this.direction,
      life: life ?? this.life,
      status: status ?? this.status,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [ life, garbage, direction, status, level ];
}