import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class Utility {

  static Size getScreenDensity () {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize / view.devicePixelRatio;
  }

  static Future<ui.Image> loadImage(String path, Size size) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes = data.buffer.asUint8List();
    img.Image? image = img.decodePng(bytes.buffer.asUint8List());
    img.Image? resized = img.copyResize(image!, width: size.width.toInt(), height: size.height.toInt());
    Uint8List resizedByteData = img.encodePng(resized);
    return await decodeImageFromList(resizedByteData);
  }

}