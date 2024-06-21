// imports nativos
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import dos pacotes
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Crash {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  void onError( String customKey, { Object? error, StackTrace? stackTrace } ) {
    Session.logs.errorLog("onError_crashlytics => $customKey - error => $error - stackTrace => $stackTrace");

    if ( _crashlytics.isCrashlyticsCollectionEnabled ) {
      Session.appEvents.sharedErrorEvent(customKey, error.toString());

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
      Session.logs.errorLog("log_crashlytics => $map");
      Session.appEvents.sharedErrorEvent(exception.message ?? exception.code, map.toString());

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