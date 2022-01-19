import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gameshow/app_builder.dart';
import 'package:gameshow/config/config_drawer.dart';
import 'config/config.dart';
import 'games/ascii_pictures/homescreen.dart';
import 'games/maze/homescreen.dart';
import 'games/secret_santa/homescreen.dart';
import 'games/tictactoe/homescreen.dart';
import 'games/explorerAI/homescreen.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      (context) {
        return MaterialApp(
          title: 'Game Show',
          themeMode: Config.getTheme(),
          theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
          darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
          initialRoute: '/',
          routes: {
            '/': (context) => const ScreenSelector(),
            '/tictactoe': (context) => const TictactoeHomeScreen(),
            '/maze': (context) => const MazeHomeScreen(),
            '/explorerAI': (context) => const ExplorerHomeScreen(),
            '/ascciPictures': (context) => const AsciiPicturesHomeScreen(),
            '/secretSanta': (context) => const SecretSantaHomeScreen(),
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Config.getLanguage() == null
              ? null
              : Locale(Config.getLanguage()!),
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}

class ScreenSelector extends StatefulWidget {
  const ScreenSelector({Key? key}) : super(key: key);

  @override
  _ScreenSelectoreState createState() => _ScreenSelectoreState();
}

class _ScreenSelectoreState extends State<ScreenSelector> {
  @override
  Widget build(BuildContext context) {
    final List<String> _gameTitles = [
      S.of(context).TicTacToe,
      S.of(context).mazeSolver,
      S.of(context).explorerAI,
      S.of(context).asciiTransformation,
      S.of(context).secretSanta,
    ];
    final List<String> _widgetsRoutes = [
      '/tictactoe',
      '/maze',
      '/explorerAI',
      '/ascciPictures',
      '/secretSanta',
    ];

    final List<Color> _colours = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.amber,
      Colors.deepPurple,
    ];

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70 * Config.getSizeFactor(),
          title: Text(
            S.of(context).selectGame,
            textScaleFactor: Config.getSizeFactor() * 1.3,
          ),
        ),
        drawer: ConfigDrawer(
          setState,
        ),
        body: ListView.builder(
          itemBuilder: (_, index) => Card(
            key: ValueKey(_gameTitles[index]),
            color: _colours[index],
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, _widgetsRoutes[index]);
              },
              leading: const Icon(
                Icons.games,
              ),
              title: Text(
                _gameTitles[index],
                textScaleFactor: Config.getSizeFactor() * 1.5,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          itemCount: _gameTitles.length,
        ));
  }
}

/* 

*/