import 'package:flutter/material.dart';
import 'package:gameshow/generated/l10n.dart';

import '../app_builder.dart';
import 'config.dart';

class ConfigDrawer extends StatefulWidget {
  final void Function(void Function()) parentSetState;
  const ConfigDrawer(this.parentSetState, {Key? key}) : super(key: key);

  @override
  _ConfigDrawerState createState() => _ConfigDrawerState();
}

class _ConfigDrawerState extends State<ConfigDrawer> {
  late double _auxSize = Config.getSizeFactor();

  @override
  void setState(void Function() fn) {
    super.setState(() {
      fn();
    });
    widget.parentSetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map<ThemeMode, String> themeString = {
      ThemeMode.dark: S.of(context).dark,
      ThemeMode.light: S.of(context).ligth,
      ThemeMode.system: S.of(context).system
    };

    Map<String, String> languages = {
      'es': S.of(context).spanish,
      'en': S.of(context).english
    };
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            S.of(context).settings,
            textScaleFactor: Config.getSizeFactor() * 2.6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            S.of(context).itemSizeSelect + ':',
            textScaleFactor: Config.getSizeFactor() * 2,
          ),
        ),
        Slider(
            value: _auxSize,
            min: 0.5,
            max: 1,
            divisions: 4,
            onChangeEnd: (value) {
              setState(() {
                Config.setSizeFactor(value);
                AppBuilder.of(context)!.rebuild();
              });
            },
            onChanged: (value) {
              setState(() {
                _auxSize = value;
              });
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                S.of(context).themeeSelect + ':',
                textScaleFactor: Config.getSizeFactor() * 2,
              ),
              const SizedBox(
                width: 10,
              ),
              DropdownButton<ThemeMode>(
                value: Config.getTheme(),
                onChanged: (newValue) {
                  setState(() {
                    Config.setTheme(newValue ?? ThemeMode.system);
                    AppBuilder.of(context)!.rebuild();
                  });
                },
                items: <ThemeMode>[...themeString.keys]
                    .map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
                  return DropdownMenuItem<ThemeMode>(
                    value: value,
                    child: Text(
                      themeString[value] ?? themeString[1] ?? 'error',
                      textScaleFactor: Config.getSizeFactor() * 1.6,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                S.of(context).languageSelect + ':',
                textScaleFactor: Config.getSizeFactor() * 2,
              ),
              const SizedBox(
                width: 10,
              ),
              DropdownButton<String>(
                value: Config.getLanguage(),
                onChanged: (newValue) {
                  setState(() {
                    Config.setLanguage(newValue ?? 'es');

                    AppBuilder.of(context)!.rebuild();
                  });
                },
                items: <String>['es', 'en']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      languages[value]!,
                      textScaleFactor: Config.getSizeFactor() * 1.6,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        )
      ],
    ));
  }
}
