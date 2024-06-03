// pacotes nativos flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// import das telas
import 'package:fc_teams_drawer/app/pages/splash/mobx/splash.dart';
import 'package:fc_teams_drawer/app/core/style/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    final SplashMobx splashMobx = SplashMobx();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Timer(
      const Duration(seconds: 3),
      () => splashMobx.goToHome(),
    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            AppImages.logoJpg,
          ),
        ),
      ),
    );
  }
}