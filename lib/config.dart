import 'package:flutter/material.dart';


// ignore_for_file: constant_identifier_names

// player
const LOG_PLAYER_COLLISION = true;

// game
const LOG_GAME_STATUS = true;

const brickColors = [
  Color(0xfff94144),
  Color(0xfff3722c),
  Color(0xfff8961e),
  Color(0xfff9844a),
  Color(0xfff9c74f),
  Color(0xff90be6d),
  Color(0xff43aa8b),
  Color(0xff4d908e),
  Color(0xff277da1),
  Color(0xff577590),
];

const gameGarbage = 0;
const gameLife = 6;
const double periodSpeedUpTime = 10;

const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.005;
const brickGutter = gameWidth * 0.015;
final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1)))
        / brickColors.length;
const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.03;       
const String controlOverlay = 'ControlOverlay';
const String infoOverlay = 'InfoOverlay';