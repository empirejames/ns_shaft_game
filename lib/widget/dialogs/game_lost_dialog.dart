import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/ns_runner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/player/player_bloc.dart';

class GameLostDialog extends StatelessWidget {
  GameLostDialog(
    this.game, {
    super.key,
  });

  final NsRunner game;

  /// For [GameWidget.overlayBuilderMap]
  static const String overlayKey = 'game-lost-dialog-key';

  String playerName = "";
  String playerRank = "";

  Future<List<String>> nameRetriever(NsRunner game) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    playerName = prefs.getString("playerName")!;
    List<String> rankList = prefs.getStringList("ranks") ?? [];
    rankList.add("$playerName-${game.bloc.state.level}");
    List<String> tmp = rankList.toSet().toList();
    playerRank = getPlayerRank(tmp);
    prefs.setStringList("ranks", sortList(tmp));
    return prefs.getStringList('ranks') ?? [];
  }

  String getPlayerRank(List<String> list) {
    for (int i = 0; i < list.length; i++) {
      String name = list[i].toString().split("-")[0];
      if (name == playerName) {
        playerRank = (i + 1).toString();
        return playerRank;
      }
    }
    return "";
  }

  List<String> sortList(List<String> list) {
    List<String> sortList = list;
    String temp = "";
    for (int i = 0; i < list.length; i++) {
      int rankOne = int.parse(list[i].toString().split("-")[1]);
      for (int j = i + 1; j < list.length; j++) {
        int rankTwo = int.parse(list[j].toString().split("-")[1]);
        if (rankOne < rankTwo) {
          temp = sortList[i];
          sortList[i] = sortList[j];
          sortList[j] = temp;
        }
      }
    }
    return sortList;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
      future: nameRetriever(game),
      builder: (_, value) {
        return Container(
          width: 300,
          height: 500,
          decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                width: 80,
                height: 80,
                image: AssetImage(
                    'assets/images/kenney_jumper_pack/PNG/Players/bunny1_hurt.png'),
              ),
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '$playerName your are in Rank $playerRank.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              if (value.data != null)
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: ListView.builder(
                      itemCount: value.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text("Rank : ${index+1} :  ${value.data![index]}" ,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                          ),);
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.read<PlayerBloc>().add(PlayerRespwanEvent());
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(80, 50),
                  backgroundColor: Colors.amberAccent,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text(
                  'Play again',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
