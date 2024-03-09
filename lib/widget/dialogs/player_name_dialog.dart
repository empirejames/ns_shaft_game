import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerNameDialog extends StatefulWidget {
  const PlayerNameDialog({
    super.key,
  });

  /// For [GameWidget.overlayBuilderMap]
  static const String overlayKey = 'game-input-name-dialog-key';

  @override
  State<PlayerNameDialog> createState() => _PlayerNameDialogState();
}

class _PlayerNameDialogState extends State<PlayerNameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> nameSaver(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('playerName', name);
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 500));
    // var currentList = prefs.getStringList('players') ?? [];
    // currentList.add(name);
    // prefs.setStringList('players', currentList);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: Container(
            width: 320,
            height: 220,
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Input player name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person), hintText: 'your name'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    await nameSaver(_controller.text.toString());
                    if (mounted) {
                      context.go('/play');
                    }
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(80, 50),
                    backgroundColor: Colors.amberAccent,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
