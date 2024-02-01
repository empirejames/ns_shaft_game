import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Utility {

  static const String ground_grass = 'kenney_jumper_pack/PNG/Environment/ground_grass.png';

  static Size getScreenDensity (){
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize / view.devicePixelRatio;
  }

}