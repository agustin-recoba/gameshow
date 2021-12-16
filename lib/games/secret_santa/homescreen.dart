import 'package:flutter/material.dart';
import 'package:gameshow/config/config.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'package:gameshow/generated/l10n.dart';

class SecretSantaHomeScreen extends StatefulWidget {
  const SecretSantaHomeScreen({Key? key}) : super(key: key);

  @override
  _SSHomeScreenState createState() => _SSHomeScreenState();
}

class _SSHomeScreenState extends State<SecretSantaHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70 * Config.getSizeFactor(),
        title: Text(
          S.of(context).secretSanta,
          textScaleFactor: Config.getSizeFactor() * 1.3,
        ),
      ),
      drawer: ConfigDrawer(setState),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'placeholder',
              textScaleFactor: Config.getSizeFactor() * 1.3,
            ),
            SizedBox(
              height: 20 * Config.getSizeFactor(),
            ),
            ElevatedButton(
              child: Text(
                'placeholder',
                textScaleFactor: Config.getSizeFactor() * 1.3,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
