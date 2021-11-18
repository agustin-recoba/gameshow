// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(role) => "${Intl.select(role, {
            'admin': 'Hi admin!',
            'manager': 'Hi manager!',
            'other': 'Hi visitor!',
          })}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: '1 message', other: '${howMany} messages')}";

  static String m2(turn) => "It\'s ${turn}\'s turn";

  static String m3(player) => "${player} wins!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "TicTacToe": MessageLookupByLibrary.simpleMessage("TicTacToe"),
        "board": MessageLookupByLibrary.simpleMessage("Board"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "difficultyEasy": MessageLookupByLibrary.simpleMessage("CPU easy"),
        "difficultyHard": MessageLookupByLibrary.simpleMessage("CPU hard"),
        "difficultyMedium": MessageLookupByLibrary.simpleMessage("CPU medium"),
        "draw": MessageLookupByLibrary.simpleMessage("Draw"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "explorerAI": MessageLookupByLibrary.simpleMessage("Explore with AI"),
        "itemSizeSelect": MessageLookupByLibrary.simpleMessage("Item size"),
        "languageSelect": MessageLookupByLibrary.simpleMessage("Language"),
        "ligth": MessageLookupByLibrary.simpleMessage("Ligth"),
        "mazeSolver": MessageLookupByLibrary.simpleMessage("Maze Solver"),
        "oponent": MessageLookupByLibrary.simpleMessage("Oponent"),
        "pageHomeWelcomeRole": m0,
        "pageNotificationsCount": m1,
        "readyPlayerOne":
            MessageLookupByLibrary.simpleMessage("Ready Player One?"),
        "selectGame": MessageLookupByLibrary.simpleMessage("Select a game:"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "spanish": MessageLookupByLibrary.simpleMessage("Spanish"),
        "startOver": MessageLookupByLibrary.simpleMessage("Start over"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "themeeSelect": MessageLookupByLibrary.simpleMessage("App theme"),
        "turnText": m2,
        "user": MessageLookupByLibrary.simpleMessage("Player 2"),
        "whoWins": m3
      };
}
