import 'package:flutter/foundation.dart';

class FcDrawerLogs {

  void successLog(String message) => _safePrint('\x1B[32m\u2714 $message\x1B[0m');
  void errorLog(String message) => _safePrint('\x1B[31m\u2718 $message\x1B[0m');

  void _safePrint(Object? o) {
    if (kDebugMode) {
      // ignore: avoid_print
      print(o);
    }
  }

}