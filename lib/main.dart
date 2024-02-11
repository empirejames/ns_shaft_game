import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/app/app.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PlayerBloc()),
      ],
      child: const NsApp(),
    ),
  );
}
