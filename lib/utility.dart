import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as UI;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/cupertino.dart';

class Utility {

  static Size getScreenDensity () {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize / view.devicePixelRatio;
  }

  static Future<UI.Image> loadImage(String path, Size size) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes = data.buffer.asUint8List();
    img.Image? image = img.decodePng(bytes.buffer.asUint8List());
    img.Image? resized = img.copyResize(image!, width: size.width.toInt(), height: size.height.toInt());
    Uint8List resizedByteData = img.encodePng(resized);
    return await decodeImageFromList(resizedByteData);
  }

}