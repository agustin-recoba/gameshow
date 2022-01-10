import 'dart:typed_data';
import 'package:gameshow/helper_classes/matrix.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart' as material;
import 'package:image/image.dart';

const String gscale1 =
    "@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjf|()1{}[]?-_+~i!lI;:,\"^`. "; //70 levels of gray
const String gscale2 = "@%#*+=-:. "; //10 levels of gray

class ImageProcessor extends material.ChangeNotifier {
  Uint8List? _uIntImg;
  late Image image;
  String url = '';
  bool ready = false;

  ImageProcessor();

  set loaded(bool value) {
    ready = value;
    notifyListeners();
  }

  Uint8List get transformedImageAsBytes {
    int width = image.width;
    int height = image.height;
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
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

  String transformedImageAsString(int scale, bool longGrayScale) {
    int tileSize = image.width ~/ scale;
    int rows = image.height ~/ tileSize;
    int cols = scale;
    String gscale = longGrayScale ? gscale1 : gscale2;

    double maxDarkness = 0;
    Matrix<double> averageDarkness = Matrix(rows, cols, (i, j) {
      double sum = 0;
      for (int k = 0; k < tileSize; k++) {
        for (int l = 0; l < tileSize; l++) {
          if (image.boundsSafe(i * tileSize + k, j * tileSize + l)) {
            int pixel = image.getPixel(i * tileSize + k, j * tileSize + l);
            int red = getRed(pixel);
            int green = getGreen(pixel);
            int blue = getBlue(pixel);
            double grey = (red + green + blue) / 3;
            sum += grey;
          }
        }
      }
      double tileAverage = sum / (tileSize * tileSize);
      maxDarkness = maxDarkness > tileAverage ? maxDarkness : tileAverage;
      return tileAverage;
    });
    StringBuffer resultBuffer = StringBuffer();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (averageDarkness.boundsSafe(j, i)) {
          var index = averageDarkness.getElem(j, i);
          index /= maxDarkness;
          resultBuffer.write(gscale[(index * (gscale.length - 1)).round()]);
        } else {
          resultBuffer.write(' ');
        }
      }
      resultBuffer.writeln();
    }
    return resultBuffer.toString();
  }

  Uint8List get originalImageAsBytes {
    return _uIntImg!;
  }

  void setUrl(String url) {
    this.url = url;
    loaded = false;
    _load();
  }

  _load() async {
    http.Response responseData = await http.get(Uri.parse(url));
    Uint8List uIntImgAux = responseData.bodyBytes;
    List<int> byteListAux = uIntImgAux.toList();
    Image? imageAux = decodeImage(byteListAux);
    if (imageAux != null) {
      _uIntImg = uIntImgAux;
      image = imageAux;
      loaded = true;
    } else {
      loaded = false;
    }
  }
}
