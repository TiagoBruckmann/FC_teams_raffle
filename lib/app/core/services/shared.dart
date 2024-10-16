// imports nativos
import 'dart:math';

// import dos domains
import 'package:fc_teams_drawer/domain/source/local/mobx/connection/connection.dart';

// import dos pacotes
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fc_teams_drawer/session.dart';

class SharedServices {

  bool validateConnection( ConnectionMobx connectionMobx ) {
    if ( connectionMobx.connectionStatus == ConnectivityResult.wifi || connectionMobx.connectionStatus == ConnectivityResult.mobile ) {
      return true;
    }
    return false;
  }

  String getRandomString( int length ) {
    const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }

  static void logSuccess( String message ) {
    _customPrint("\x1B[32m\u2714 $message\x1B[0m");
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