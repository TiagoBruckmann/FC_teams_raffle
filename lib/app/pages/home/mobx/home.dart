// imports globais
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/team_usecase.dart';
import 'package:fc_teams_drawer/session.dart';

// import dos pacotes
import 'package:new_version_plus/new_version_plus.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobx/mobx.dart';

part 'home.g.dart';

class HomeMobx extends _HomeMobx with _$HomeMobx {}

abstract class _HomeMobx with Store {

  final _teamUseCase = TeamUseCase(getIt());

  final currentContext = Session.globalContext.currentContext!;

  Future<void> _getTeams() async {

    if ( Session.teams.isNotEmpty ) return;

    final response = await _teamUseCase.getDataSync();

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) => Session.logs.successLog("success_getDataSync_home"),
    );

  }

  @action
  Future<void> verifyVersion() async {
    final newVersion = NewVersionPlus();
    final status = await newVersion.getVersionStatus();
    if ( status != null && currentContext.mounted ) {
      if ( status.canUpdate && int.parse(status.localVersion.replaceAll(".", "")) < int.parse(status.storeVersion.replaceAll(".", "")) ) {

        await Session.appEvents.sharedEventString("new_version", status.storeVersion);

        newVersion.showUpdateDialog(
          context: currentContext,
          allowDismissal: false,
          versionStatus: status,
          dialogTitle: FlutterI18n.translate(currentContext, "pages.update.title"),
          dialogText: FlutterI18n.translate(currentContext, "pages.update.subtitle"),
          updateButtonText: FlutterI18n.translate(currentContext, "btn_update"),
          launchModeVersion: LaunchModeVersion.external,
        );

      }
    }

    await _getTeams();
  }

  @action
  Future<void> goToTerms() async {
    final url = Uri.https("tiagobruckmann.dev", "security/privacy_policy_fc_raffle.html");

    try {
      if ( await canLaunchUrl(url) ) {
        Session.appEvents.sharedEvent("opening_terms");

        launchUrl(url);

        return;
      }
    } catch ( error ) {
      SharedServices.logError("open_terms", message: error.toString());
      return;
    }

  }

  @action
  void goToResponse({ bool isSolo = true }) {

    final map = {
      "is_solo": isSolo,
    };

    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.resultRaffle.name, extra: map);
  }

  @action
  void goToTournament() => NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.tournament.name);

}