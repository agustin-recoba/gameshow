import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart' as mat;
import 'package:image/image.dart';

class ImageProcessor {
  String url;
  late Uint8List img;

  ImageProcessor(this.url);

  mat.ValueNotifier<bool> loaded = mat.ValueNotifier(false);

  Uint8List get imageBytes {
    List<int> list = img.toList();
    Image? image = decodeImage(list);
    for (int i = 0; i < image!.width; i++) {
      for (int j = 0; j < image.height; j++) {
        int pixel = image.getPixel(i, j);
        int red = getRed(pixel);
        int green = getGreen(pixel);
        int blue = getBlue(pixel);

        int grey = (red + green + blue) ~/ 3;
        image.setPixel(i, j, getColor(grey, grey, grey, getAlpha(pixel)));
      }
    }
    return Uint8List.fromList(encodePng(image));
  }

  void setUrl(String url) {
    this.url = url;
    load();
  }

  load() async {
    http.Response responseData = await http.get(Uri.parse(url));
    img = responseData.bodyBytes;
    loaded.value = true;
  }
}
