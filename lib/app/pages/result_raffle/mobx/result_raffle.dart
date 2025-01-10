import 'dart:math';
import 'package:fc_teams_drawer/domain/entity/team.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:mobx/mobx.dart';

part 'result_raffle.g.dart';

class ResultRaffleMobx extends _ResultRaffleMobx with _$ResultRaffleMobx {}

abstract class _ResultRaffleMobx with Store {

  ObservableList<TeamEntity> teamsList = ObservableList();

  @action
  Future<void> sortTeams() async {

    final random = Random();

    int totalTeams = Session.teams.length;

    final player1 = Session.teams[random.nextInt(totalTeams)];
    TeamEntity player2 = Session.teams[random.nextInt(totalTeams)];

    while ( player2 == player1 ) {
      player2 = Session.teams[random.nextInt(totalTeams)];
    }

    teamsList.add(player1);
    teamsList.add(player2);
    await Session.appEvents.sharedEventString("raffle_teams", teamsList.toString());

    return;
  }

}