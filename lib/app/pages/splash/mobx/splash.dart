import 'dart:async';
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/team_usecase.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:mobx/mobx.dart';

part 'splash.g.dart';

class SplashMobx extends _SplashMobx with _$SplashMobx {}

abstract class _SplashMobx with Store {

  final _useCase = TeamUseCase(getIt());

  @action
  void startTimer() {
    _getDataSync();
    Timer(
      const Duration(seconds: 3),
      () => _goToHome(),
    );
  }

  @action
  Future<void> _getDataSync() async {

    final successOrFailure = await _useCase.getDataSync();

    successOrFailure.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) => Session.logs.successLog("success_getDataSync_splash"),
    );

  }

  @action
  void _goToHome() => NavigationRoutes.navigation(NavigationTypeEnum.pushAndRemoveUntil.value, RoutesNameEnum.home.name);

}