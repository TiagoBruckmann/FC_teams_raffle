// imports globais
import 'dart:io';

// import dos pacotes
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AppEvents {

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> sendScreen( String screenName, { String? params } ) async {
    await _analytics.logScreenView(
      screenName: screenName,
      parameters: {
        "params": params,
      },
    );
  }

  Future<void> sharedSuccessEvent( String eventName, String success ) async {
    final params = {
      "success": success,
    };

    _logEvent(eventName, params);
  }

  Future<void> sharedErrorEvent( String eventName, String error ) async {
    final params = {
      "error": error,
    };

    _logEvent(eventName, params);
  }

  Future<void> sharedEvent( String eventName ) async {
    _logEvent(eventName, {});
  }

  Future<void> sharedEventString( String eventName, String param ) async {
    final params = {
      "data": param,
    };

    _logEvent(eventName, params);
  }

  Future<void> _logEvent(String eventName, Map<String, String> params) async {

    NewVersionPlus versionPlus = NewVersionPlus();
    final version = await versionPlus.getVersionStatus();

    if ( version != null ) {
      params.addAll({
        'app_version': version.localVersion,
      });
    }

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String platform = "Android";
    dynamic deviceInfo;
    if ( Platform.isIOS ) {
      deviceInfo = await deviceInfoPlugin.iosInfo;
      platform = "IOS";
    } else {
      deviceInfo = await deviceInfoPlugin.androidInfo;
    }

    params.addAll({
      'platform': platform,
      'device': deviceInfo.model,
      'device_version': ( Platform.isIOS ) ? deviceInfo.systemVersion : deviceInfo.version.release,
    });

    await _analytics.logEvent(
      name: eventName,
      parameters: params,
    );
  }

}