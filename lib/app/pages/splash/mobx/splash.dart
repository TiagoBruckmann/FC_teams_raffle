// imports telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'splash.g.dart';

class SplashMobx extends _SplashMobx with _$SplashMobx {}

abstract class _SplashMobx with Store {

  @action
  void goToHome() => NavigationRoutes.navigation(NavigationTypeEnum.pushAndRemoveUntil.value, "/");

}