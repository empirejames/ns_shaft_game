part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.life = 10,
  });

  final int life;

  @override
  List<Object?> get props => [ life ];
}