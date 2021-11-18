// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(role) => "${Intl.select(role, {
            'admin': 'Hi admin!',
            'manager': 'Hi manager!',
            'other': 'Hi visitor!',
          })}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: '1 message', other: '${howMany} messages')}";

  static String m2(turn) => "Es el turno de ${turn}";

  static String m3(player) => "¡${player} ganó!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "TicTacToe": MessageLookupByLibrary.simpleMessage("Ta-Te-Tí"),
        "board": MessageLookupByLibrary.simpleMessage("Tablero"),
        "dark": MessageLookupByLibrary.simpleMessage("Oscuro"),
        "difficultyEasy": MessageLookupByLibrary.simpleMessage("CPU fácil"),
        "difficultyHard": MessageLookupByLibrary.simpleMessage("CPU difícil"),
        "difficultyMedium": MessageLookupByLibrary.simpleMessage("CPU medio"),
        "draw": MessageLookupByLibrary.simpleMessage("Empate"),
        "english": MessageLookupByLibrary.simpleMessage("Inglés"),
        "explorerAI": MessageLookupByLibrary.simpleMessage("Explorar con IA"),
        "itemSizeSelect":
            MessageLookupByLibrary.simpleMessage("Tamaño de los items"),
        "languageSelect": MessageLookupByLibrary.simpleMessage("Idioma"),
        "ligth": MessageLookupByLibrary.simpleMessage("Claro"),
        "mazeSolver":
            MessageLookupByLibrary.simpleMessage("Resolver laberintos"),
        "oponent": MessageLookupByLibrary.simpleMessage("Oponente"),
        "pageHomeWelcomeRole": m0,
        "pageNotificationsCount": m1,
        "readyPlayerOne":
            MessageLookupByLibrary.simpleMessage("¿Listo para jugar?"),
        "selectGame":
            MessageLookupByLibrary.simpleMessage("Seleccionar juego:"),
        "settings": MessageLookupByLibrary.simpleMessage("Configuraciones"),
        "spanish": MessageLookupByLibrary.simpleMessage("Español"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "themeeSelect": MessageLookupByLibrary.simpleMessage("Tema de la app"),
        "turnText": m2,
        "user": MessageLookupByLibrary.simpleMessage("Jugador 2"),
        "whoWins": m3
      };
}
