// imports nativos
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/team.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'create_tournament.g.dart';

class CreateTournamentMobx extends _CreateTournamentMobx with _$CreateTournamentMobx {}

abstract class _CreateTournamentMobx with Store {

  final _tournamentUseCase = TournamentUseCase(getIt());

  TextEditingController eventNameController = TextEditingController(text: kDebugMode ? "Teste" : "");

  ObservableList<TextEditingController> playersController = ObservableList();

  ObservableList<TextEditingController> teamsNameController = ObservableList();

  ObservableList<PlayerEntity> listPlayers = ObservableList();

  ObservableList<MatchEntity> listMatches = ObservableList();

  final List<TeamEntity> sortTeamsList = [];

  @observable
  bool isLoading = true;

  @observable
  int qtdPlayers = 0;

  @observable
  int qtdDefeats = 0;

  @observable
  bool raffleTeams = true;

  @action
  void initialSettings() {
    setQtdPlayers(3);
    setQtdDefeats(2);
    updIsLoading(false);
  }

  @action
  void updIsLoading( bool value ) => isLoading = value;

  @action
  void setQtdPlayers( int value ) {

    final List<TextEditingController> players = List.from(playersController);
    final List<TextEditingController> teams = List.from(teamsNameController);

    if ( playersController.isNotEmpty ) {
      playersController.clear();
      teamsNameController.clear();
    }

    if ( players.length > value ) {
      players.removeRange(value, players.length);
      teams.removeRange(value, teams.length);
    }

    playersController.addAll(players);
    teamsNameController.addAll(teams);

    while ( playersController.length < value ) {

      playersController.add(
        TextEditingController(),
      );

      teamsNameController.add(
        TextEditingController(),
      );

    }

    qtdPlayers = value;
  }

  @action
  void setQtdDefeats( int value ) => qtdDefeats = value;

  @action
  void updRaffleTeams() => raffleTeams = !raffleTeams;

  @action
  void validateFields() {

    updIsLoading(true);

    if ( eventNameController.text.trim().isEmpty || eventNameController.text.trim().length < 3 ) {
      CustomSnackBar(messageKey: "pages.tournament.create.invalid_name");
      updIsLoading(false);
      return;
    }

    bool isValidText = true;
    for ( final item in playersController ) {

      if ( item.text.trim().isEmpty || item.text.trim().length < 3 ) {
        isValidText = false;
      }

    }

    if ( !isValidText ) {
      CustomSnackBar(messageKey: "pages.tournament.create.invalid_players_name");
      updIsLoading(false);
      return;
    }

    _saveTournament();
    return;
  }

  @action
  Future<void> _saveTournament() async {

    final dateNow = DateTime.now();
    final day = Session.sharedServices.convertDate(dateNow.day);
    final month = Session.sharedServices.convertDate(dateNow.month);

    final date = "$day/$month/${dateNow.year}";
    final createdAt = DateFormat("yyyyMMddkkmmss").format(dateNow);

    final tournament = TournamentEntity(
      Session.sharedServices.getRandomString(20),
      eventNameController.text.trim(),
      date,
      raffleTeams,
      true,
      qtdDefeats,
      false,
      createdAt,
    );

    final response = await _tournamentUseCase.createTournament(tournament);

    response.fold(
      ( failure ) {
        CustomSnackBar(messageKey: "pages.tournament.create.invalid_name");
        updIsLoading(false);
      },
      ( tournamentId ) => _createTournamentMapper(tournament),
    );

  }

  @action
  Future<void> _createTournamentMapper( TournamentEntity tournament ) async {

    /*
    final playersIds = await _getPlayers();
    final matchesIds = await _getMatches();

    final List<TournamentMapperEntity> tournamentMapperList = [];

    for ( final playerId in playersIds ) {
      tournamentMapperList.add(
        TournamentMapperEntity.fromPlayerId(tournament.id!, playerId),
      );
    }

    for ( final matchId in matchesIds ) {
      tournamentMapperList.add(
        TournamentMapperEntity.fromMatchId(tournament.id!, matchId),
      );
    }

    final response = await _tournamentUseCase.createOrUpdateTournamentMapper(tournamentMapperList);

    updIsLoading(false);

    listMatches.sort((a, b) => b.round.compareTo(a.round));

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (mappersIds) {
        tournament = TournamentEntity.fromMapper(tournament, listPlayers, listMatches);
        _goToBoard(tournament);
      },
    );
    */
  }

  @action
  Future<List<int>> _getPlayers() async {

    /*
    final List<String> listTeams = [];

    for ( int i = 0; i < playersController.length; i++ ) {

      final player = playersController[i].text.trim();
      String logo = teamsNameController[i].text.trim().toLowerCase().replaceAll(" ", "_");

      if ( raffleTeams ) {

        logo = await _sortTeams(listTeams);
        listTeams.add(logo);

      }

      listPlayers.add(
        PlayerEntity(
          player,
          logo,
          0,
        ),
      );

    }

    listTeams.clear();

    final ids = await _tournamentUseCase.createPlayers(listPlayers);

    List<int> playersIds = [];
    ids.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (ids) => playersIds.addAll(ids),
    );

    return playersIds;
     */

    return [1];
  }

  @action
  Future<String> _sortTeams( List<String> listTeams ) async {

    if ( sortTeamsList.isNotEmpty ) {
      return _sortFilteredTeams(listTeams);
    }

    final random = Random();

    int totalTeams = Session.teams.length;

    TeamEntity team = Session.teams[random.nextInt(totalTeams)];
    final minimumScore = team.score - 3;
    final maximumScore = team.score + 3;

    sortTeamsList.addAll(List.from(Session.teams.where((team) => team.score >= minimumScore && team.score <= maximumScore)));
    sortTeamsList.removeWhere((entity) => listTeams.contains(team.logo) || entity.logo == team.logo);
    totalTeams = sortTeamsList.length;

    while ( listTeams.contains(team.logo) ) {
      team = sortTeamsList[random.nextInt(totalTeams)];
    }

    sortTeamsList.removeWhere((entity) => entity.logo == team.logo);

    return team.logo;
  }

  @action
  Future<String> _sortFilteredTeams( List<String> listTeams ) async {
    final random = Random();

    int totalTeams = sortTeamsList.length;

    TeamEntity team = sortTeamsList[random.nextInt(totalTeams)];
    int minimumScore = team.score - 3;
    int maximumScore = team.score + 3;

    sortTeamsList.removeWhere((entity) => listTeams.contains(team.logo) || entity.logo == team.logo);
    totalTeams = sortTeamsList.length;

    if ( sortTeamsList.length <= 2 ) {

      minimumScore = team.score - 3;
      maximumScore = team.score + 3;

      sortTeamsList.addAll(List.from(Session.teams.where((team) => team.score >= minimumScore && team.score <= maximumScore)));
      sortTeamsList.removeWhere((entity) => listTeams.contains(team.logo) || entity.logo == team.logo);
      totalTeams = sortTeamsList.length;

    }

    while ( listTeams.contains(team.logo) ) {
      team = sortTeamsList[random.nextInt(totalTeams)];
    }

    sortTeamsList.removeWhere((entity) => entity.logo == team.logo);

    return team.logo;
  }

  @action
  Future<List<int>> _getMatches() async {

    /*
    final random = Random();
    int round = 1;
    final List<PlayerEntity> players = List.from(listPlayers);

    while ( players.isNotEmpty ) {

      final player1 = players[random.nextInt(players.length)];
      players.removeWhere((element) => element.isEqual(player1) );
      final totalPlayers = players.length;

      PlayerEntity player2 = PlayerEntity.nextWinner();
      if ( totalPlayers > 0 ) {
        final secondPlayer = players[random.nextInt(players.length)];
        players.removeWhere((element) => element.isEqual(secondPlayer) );
        player2 = secondPlayer;
      }

      listMatches.add(
        MatchEntity(
          player1.name,
          player1.team,
          player2.name,
          player2.team,
          "",
          round,
        ),
      );

      round++;

    }

    final ids = await _tournamentUseCase.createOrUpdateMatches(listMatches);

    List<int> matchesIds = [];
    ids.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (ids) => matchesIds.addAll(ids),
    );

    return matchesIds;
     */
    return [1];
  }

  @action
  void _goToBoard( TournamentEntity tournament ) {
    NavigationRoutes.navigation(NavigationTypeEnum.pop.value, "");
    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name, extra: tournament);
  }

}