import 'dart:math';
import 'package:fc_teams_drawer/domain/entity/team.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/team_usecase.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:mobx/mobx.dart';

part 'result_raffle.g.dart';

class ResultRaffleMobx extends _ResultRaffleMobx with _$ResultRaffleMobx {}

abstract class _ResultRaffleMobx with Store {

  final _teamUseCase = TeamUseCase(getIt());

  ObservableList<TeamEntity> teamsList = ObservableList();

  @action
  Future<void> getTeams() async {

    if ( Session.teams.isNotEmpty ) {
      return await _sortTeams();
    }

    final response = await _teamUseCase.getDataSync();

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) async => await _sortTeams(),
    );

  }

  @action
  Future<void> _sortTeams() async {

    final random = Random();

    int totalTeams = Session.teams.length;

    final player1 = Session.teams[random.nextInt(totalTeams)];
    final minimumScore = player1.score - 3;
    final maximumScore = player1.score + 3;

    final List<TeamEntity> list = List.from(Session.teams.where((team) => team.score >= minimumScore && team.score <= maximumScore));
    list.removeWhere((team) => team.logo == player1.logo);
    totalTeams = list.length;

    TeamEntity player2 = list[random.nextInt(totalTeams)];

    teamsList.add(player1);
    teamsList.add(player2);
    await Session.appEvents.sharedEventString("raffle_teams", teamsList.toString());

    return;
  }

}