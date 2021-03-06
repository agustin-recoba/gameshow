// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select a game:`
  String get selectGame {
    return Intl.message(
      'Select a game:',
      name: 'selectGame',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Game specific settings`
  String get drawerExtraSettings {
    return Intl.message(
      'Game specific settings',
      name: 'drawerExtraSettings',
      desc: '',
      args: [],
    );
  }

  /// `Item size`
  String get itemSizeSelect {
    return Intl.message(
      'Item size',
      name: 'itemSizeSelect',
      desc: '',
      args: [],
    );
  }

  /// `App theme`
  String get themeSelect {
    return Intl.message(
      'App theme',
      name: 'themeSelect',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languageSelect {
    return Intl.message(
      'Language',
      name: 'languageSelect',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `TicTacToe`
  String get TicTacToe {
    return Intl.message(
      'TicTacToe',
      name: 'TicTacToe',
      desc: '',
      args: [],
    );
  }

  /// `It's {turn}'s turn`
  String turnText(Object turn) {
    return Intl.message(
      'It\'s $turn\'s turn',
      name: 'turnText',
      desc: '',
      args: [turn],
    );
  }

  /// `Board`
  String get board {
    return Intl.message(
      'Board',
      name: 'board',
      desc: '',
      args: [],
    );
  }

  /// `Player 2`
  String get user {
    return Intl.message(
      'Player 2',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `CPU easy`
  String get difficultyEasy {
    return Intl.message(
      'CPU easy',
      name: 'difficultyEasy',
      desc: '',
      args: [],
    );
  }

  /// `CPU medium`
  String get difficultyMedium {
    return Intl.message(
      'CPU medium',
      name: 'difficultyMedium',
      desc: '',
      args: [],
    );
  }

  /// `CPU hard`
  String get difficultyHard {
    return Intl.message(
      'CPU hard',
      name: 'difficultyHard',
      desc: '',
      args: [],
    );
  }

  /// `Start over`
  String get startOver {
    return Intl.message(
      'Start over',
      name: 'startOver',
      desc: '',
      args: [],
    );
  }

  /// `Opponent`
  String get opponent {
    return Intl.message(
      'Opponent',
      name: 'opponent',
      desc: '',
      args: [],
    );
  }

  /// `{player} wins!`
  String whoWins(Object player) {
    return Intl.message(
      '$player wins!',
      name: 'whoWins',
      desc: '',
      args: [player],
    );
  }

  /// `Draw`
  String get draw {
    return Intl.message(
      'Draw',
      name: 'draw',
      desc: '',
      args: [],
    );
  }

  /// `Ready Player One?`
  String get readyPlayerOne {
    return Intl.message(
      'Ready Player One?',
      name: 'readyPlayerOne',
      desc: '',
      args: [],
    );
  }

  /// `Maze Solver`
  String get mazeSolver {
    return Intl.message(
      'Maze Solver',
      name: 'mazeSolver',
      desc: '',
      args: [],
    );
  }

  /// `Maze height`
  String get mazeHeight {
    return Intl.message(
      'Maze height',
      name: 'mazeHeight',
      desc: '',
      args: [],
    );
  }

  /// `Maze width`
  String get mazeWidth {
    return Intl.message(
      'Maze width',
      name: 'mazeWidth',
      desc: '',
      args: [],
    );
  }

  /// `Explore with AI`
  String get explorerAI {
    return Intl.message(
      'Explore with AI',
      name: 'explorerAI',
      desc: '',
      args: [],
    );
  }

  /// `Secret Santa`
  String get secretSanta {
    return Intl.message(
      'Secret Santa',
      name: 'secretSanta',
      desc: '',
      args: [],
    );
  }

  /// `Ascii Transformation`
  String get asciiTransformation {
    return Intl.message(
      'Ascii Transformation',
      name: 'asciiTransformation',
      desc: '',
      args: [],
    );
  }

  /// `Precision`
  String get precision {
    return Intl.message(
      'Precision',
      name: 'precision',
      desc: '',
      args: [],
    );
  }

  /// `More characters`
  String get moreChars {
    return Intl.message(
      'More characters',
      name: 'moreChars',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
