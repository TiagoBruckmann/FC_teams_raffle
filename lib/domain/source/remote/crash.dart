// imports nativos
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import dos pacotes
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Crash {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  void userConnected(String userId) async {
    if ( _crashlytics.isCrashlyticsCollectionEnabled ) {
      await _crashlytics.setUserIdentifier(userId);
    }
  }

  void onError( String customKey, { Object? error, StackTrace? stackTrace } ) {
    if ( _crashlytics.isCrashlyticsCollectionEnabled ) {
      _crashlytics.recordError(error, stackTrace);
      _crashlytics.setCustomKey("error_message", customKey);
    }
  }

  void log( PlatformException exception) {
    if ( _crashlytics.isCrashlyticsCollectionEnabled ) {
      final map = {
        "code": exception.code,
        "message": exception.message,
        "details": exception.details,
        "stacktrace": exception.stacktrace,
      };
      _crashlytics.log("${exception.code} - ${exception.details}");
      _crashlytics.setCustomKey("error_message", map.toString());
    }

    FlutterError.reportError(
      FlutterErrorDetails(
        exception: exception,
        library: "${exception.message}",
        context: ErrorSummary("${exception.details}"),
      ),
    );
  }

}