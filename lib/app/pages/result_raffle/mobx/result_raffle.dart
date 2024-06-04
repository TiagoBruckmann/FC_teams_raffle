import 'dart:math';

import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:mobx/mobx.dart';

part 'result_raffle.g.dart';

class ResultRaffleMobx extends _ResultRaffleMobx with _$ResultRaffleMobx {}

abstract class _ResultRaffleMobx with Store {

  ObservableList<TeamCollection> teamsList = ObservableList();

  @action
  Future<void> sortTeams() async {

    final random = Random();

    int totalTeams = Session.fcTeamCollection.teamCollection!.length;

    final player1 = Session.fcTeamCollection.teamCollection![random.nextInt(totalTeams)];
    TeamCollection player2 = Session.fcTeamCollection.teamCollection![random.nextInt(totalTeams)];

    while ( player2 == player1 ) {
      player2 = Session.fcTeamCollection.teamCollection![random.nextInt(totalTeams)];
    }

    teamsList.add(player1);
    teamsList.add(player2);

    return;
  }

}