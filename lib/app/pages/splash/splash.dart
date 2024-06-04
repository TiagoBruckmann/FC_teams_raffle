import 'package:flutter/material.dart';
import 'package:fc_teams_drawer/app/pages/splash/mobx/splash.dart';
import 'package:fc_teams_drawer/app/core/style/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final SplashMobx _splashMobx = SplashMobx();

  @override
  void initState() {
    super.initState();
    _splashMobx.startTimer();
  }

  @override
  Widget build(BuildContext context) {
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