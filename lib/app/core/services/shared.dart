// import dos domains
import 'dart:math';

// import dos pacotes
import 'package:fc_teams_drawer/session.dart';

class SharedServices {

  static String convertDate( int value ) {

    String converted = value.toString();
    if ( value < 10 ) {
      converted = "0$value";
    }

    return converted;
  }

  static int getRandomString( int length ) {
    const chars = '1234567890';
    final Random rnd = Random();

    return int.parse(String.fromCharCodes(
      Iterable.generate(
        length,
          (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    ));
  }

  static void logError( String code, { String? message }) {
    String text = "Error: $code - Error Message: ${message ?? ""}";
    Session.crash.onError(code, error: text);
    _customPrint("\x1B[31m\u2718 $text\x1B[0m");
  }

  static void _customPrint( String message ) {
    // ignore: avoid_print
    return print(message);
  }

}