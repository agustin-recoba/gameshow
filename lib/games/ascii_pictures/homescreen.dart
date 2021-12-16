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
  ValueNotifier<String> url = ValueNotifier<String>(
      'https://http2.mlstatic.com/storage/mshops-appearance-api/images/15/254304515/logo-2020060212005277900.png');
  late ImageProcessor processor = ImageProcessor(url.value);
  String internalUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ConfigDrawer(setState),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh)),
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(S.of(context).ascciTransformation,
            textScaleFactor: Config.getSizeFactor() * 1.2),
      ),
      body: ListView(
        children: [
          TextFormField(
            initialValue: url.value,
            onEditingComplete: () {
              url.value = internalUrl;
              processor.setUrl(internalUrl);
            },
            onChanged: (val) {
              internalUrl = val;
            },
          ),
          AnimatedBuilder(
              animation: url,
              builder: (context, child) {
                return Image.network(url.value);
              }),
          AnimatedBuilder(
              animation: processor.loaded,
              builder: (context, child) {
                if (processor.loaded.value) {
                  return Image.memory(processor.imageBytes);
                } else {
                  processor.load();
                  return const Placeholder();
                }
              })
        ],
      ),
    );
  }
}
