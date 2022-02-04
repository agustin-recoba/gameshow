import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'package:gameshow/generated/l10n.dart';

import 'game_logic/image_converter.dart';

class AsciiPicturesHomeScreen extends StatefulWidget {
  const AsciiPicturesHomeScreen({Key? key}) : super(key: key);

  @override
  AsciiPicturesHomeScreenState createState() => AsciiPicturesHomeScreenState();
}

class AsciiPicturesHomeScreenState extends State<AsciiPicturesHomeScreen> {
  late ImageProcessor processor = ImageProcessor();
  String _internalUrl = 'https://i.imgur.com/JqH8J4n.jpeg';
  int _imageScale = 100;
  double _auxSize = 100;
  final ValueNotifier<bool> _longString = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    processor.setUrl(_internalUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ConfigDrawer(setState,
          pageSpecificSettings: asciiPicturesSettings(context)),
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(S.of(context).asciiTransformation,
            textScaleFactor: Config.getSizeFactor() * 1.2),
      ),
      body: ListView(
        children: [
          TextFormField(
            initialValue: _internalUrl,
            onEditingComplete: () {
              processor.setUrl(_internalUrl);
              FocusScope.of(context).unfocus();
            },
            onChanged: (val) {
              _internalUrl = val;
            },
          ),
          AnimatedBuilder(
              animation: processor,
              builder: (context, child) {
                if (processor.ready) {
                  Uint8List? orig = processor.originalImageAsBytes;
                  Uint8List? newImg = processor.transformedImageAsBytes;
                  return Column(
                    children: [
                      const Icon(Icons.arrow_downward),
                      Image.memory(orig),
                      const Icon(Icons.arrow_downward),
                      Image.memory(newImg),
                      const Icon(Icons.arrow_downward),
                      AnimatedBuilder(
                          animation: _longString,
                          builder: (_, __) {
                            return Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: SelectableText(
                                    processor.transformedImageAsString(
                                        _imageScale, _longString.value),
                                    style: const TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontFeatures: [
                                          FontFeature.tabularFigures(),
                                        ],
                                        height: 0.8),
                                  ),
                                ),
                              ],
                            );
                          })
                    ],
                  );
                } else {
                  return const Placeholder();
                }
              }),
        ],
      ),
    );
  }

  List<Widget> asciiPicturesSettings(BuildContext context) {
    return [
      Text(
        S.of(context).precision + ': ',
        textScaleFactor: Config.getSizeFactor() * 2,
      ),
      Slider(
          value: _auxSize.toDouble(),
          min: 25,
          max: 200,
          onChangeEnd: (value) {
            setState(() {
              _auxSize = value;
              _imageScale = value.toInt();
            });
          },
          onChanged: (value) {
            setState(() {
              _auxSize = value;
            });
          }),
      Text(
        S.of(context).moreChars,
        textScaleFactor: Config.getSizeFactor() * 2,
      ),
      AnimatedBuilder(
          animation: _longString,
          builder: (_, __) => Switch(
              value: _longString.value,
              onChanged: (value) {
                _longString.value = value;
              }))
    ];
  }
}
