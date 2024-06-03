// imports telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/domain/entities/team.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'home.g.dart';

class HomeMobx extends _HomeMobx with _$HomeMobx {}

abstract class _HomeMobx with Store {

  @action
  void goToResponse( bool isSolo ) {

    final map = {
      "is_solo": isSolo,
      "teams": const [
        TeamEntity(
          "Inter de Milão",
          "Italiana",
          "inter_milao",
        ),
        TeamEntity(
          "Liverpool",
          "Inglesa",
          "liverpool",
        ),
      ],
    };

    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, "/result-raffle", extra: map);
  }

  @action
  void goToSolo() => NavigationRoutes.navigation(NavigationTypeEnum.push.value, "/solo");

  @action
  void goToX1() => NavigationRoutes.navigation(NavigationTypeEnum.push.value, "/x1");

  @action
  void goToTournament() => NavigationRoutes.navigation(NavigationTypeEnum.push.value, "/tournament");

}