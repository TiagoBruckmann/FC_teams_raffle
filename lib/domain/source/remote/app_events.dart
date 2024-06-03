// imports globais
import 'dart:io';

// import dos pacotes
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AppEvents {

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> sendScreen( String screenName, { Map<String, dynamic>? params } ) async {
    await _analytics.logScreenView(
      screenName: screenName,
      parameters: params,
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

  Future<void> login( String loginMethod ) async{
    await _analytics.logSignUp(signUpMethod: loginMethod);
  }

  Future<void> _logEvent(String eventName, Map<String, String> params) async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
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
      'app_version': packageInfo.version,
    });

    await _analytics.logEvent(
      name: eventName,
      parameters: params,
    );
  }

}