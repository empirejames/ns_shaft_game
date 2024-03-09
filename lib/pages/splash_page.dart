import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/app/app_runtime_config.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/core/utilities/my_platform_utility.dart';
import 'package:game_failing_down/core/utilities/utilities.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:game_failing_down/pages/game_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isDesktop = MyPlatformUtility.isDesktop;
      final runtimeConfig = AppRuntimeConfig.instance..init(context);
      final navigator = Navigator.of(context);
      final bloc = context.read<PlayerBloc>();

      if (isDesktop) {
        await DesktopUtility.init();
      }

      // final nsGame = NsRunner(bloc: bloc);

      // navigator.pushReplacement(
      //   MaterialPageRoute(builder: (_) => GamePage(nsGame: nsGame)),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
