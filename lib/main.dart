import 'package:fc_teams_drawer/app/core/routes/routes.dart';
import 'package:fc_teams_drawer/app/core/services/firebase_options.dart';
import 'package:fc_teams_drawer/app/core/services/languages.dart';
import 'package:fc_teams_drawer/app/core/style/themes.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/source/local/mobx/connection/connection.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    return true;
  };

  await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);

  configureDependencies();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ConnectionMobx(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: Session.globalContext,
        title: "FC sorteador",
        // theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        theme: Themes.darkTheme,
        onGenerateRoute: Routes.generateRoutes,
        initialRoute: "/splash",
        supportedLocales: supportedLocale,
        localizationsDelegates: localizationsDelegate,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
