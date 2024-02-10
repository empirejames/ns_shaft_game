import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_failing_down/bloc/player/player_bloc.dart';
import 'package:game_failing_down/others/asset_path.dart';

const double _controlSize = 80.0;

class ControlOverlay extends StatefulWidget {
  const ControlOverlay({
    super.key,
  });

  @override
  State<ControlOverlay> createState() => _ControlOverlayState();
}

class _ControlOverlayState extends State<ControlOverlay> {
  Direction _direction = Direction.none;

  /// [direction] cannot be [Direction.none]
  Widget _buildArrowButton(BuildContext context, {
    required Direction direction,
    required String assetPath,
    required String assetPathPressed,
  }) {
    return Align(
      alignment: direction == Direction.left ? Alignment.bottomLeft : Alignment.bottomRight,
      child: GestureDetector(
        onTapDown: (_) {
          context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(direction));
          setState(() {
            _direction = direction;
          });
        },
        onTapUp: (_) {
          if (_direction == direction) {
            context.read<PlayerBloc>().add(PlayerUpdateDirectionEvent(Direction.none));
            setState(() {
              _direction = Direction.none;
            });
          }
        },
        child: SizedBox(
          width: _controlSize,
          height: _controlSize,
          child: Image.asset(
            _direction == direction ? assetPathPressed : assetPath,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
      child: Stack(
        children: [
          _buildArrowButton(
            context,
            direction: Direction.left,
            assetPath: '${AssetPaths.prefix}/${AssetPaths.arrow_left_idle}',
            assetPathPressed: '${AssetPaths.prefix}/${AssetPaths.arrow_left_pressed}',
          ),
          _buildArrowButton(
            context,
            direction: Direction.right,
            assetPath: '${AssetPaths.prefix}/${AssetPaths.arrow_right_idle}',
            assetPathPressed: '${AssetPaths.prefix}/${AssetPaths.arrow_right_pressed}',
          ),
        ],
      ),
    );
  }
}