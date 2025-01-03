// imports nativos
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/team.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'create_tournament.g.dart';

class CreateTournamentMobx extends _CreateTournamentMobx with _$CreateTournamentMobx {}

abstract class _CreateTournamentMobx with Store {

  final _tournamentUseCase = TournamentUseCase(getIt());

  TextEditingController eventNameController = TextEditingController(text: "Teste");

  ObservableList<TextEditingController> playersController = ObservableList();

  ObservableList<PlayerEntity> listPlayers = ObservableList();

  ObservableList<MatchEntity> listMatches = ObservableList();

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

    if ( playersController.isNotEmpty ) {
      playersController.clear();
    }

    while ( playersController.length < value ) {
      playersController.add(
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
    final day = SharedServices.convertDate(dateNow.day);
    final month = SharedServices.convertDate(dateNow.month);

    final date = "$day/$month/${dateNow.year}";
    final createdAt = DateFormat("yyyyMMddkkmmss").format(dateNow);

    final tournament = TournamentEntity(
      eventNameController.text.trim(),
      date,
      raffleTeams,
      true,
      qtdDefeats,
      createdAt,
    );

    final response = await _tournamentUseCase.createTournament(tournament);

    response.fold(
      ( failure ) {
        CustomSnackBar(messageKey: "pages.tournament.create.invalid_name");
        updIsLoading(false);
      },
      ( tournamentId ) => _createTournamentMapper(tournament.setTournamentId(tournamentId)),
    );

  }

  @action
  Future<void> _createTournamentMapper( TournamentEntity tournament ) async {

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
  }

  @action
  Future<List<int>> _getPlayers() async {

    final List<String> listTeams = [];

    for ( final item in playersController ) {

      String logo = "";

      if ( raffleTeams ) {
        logo = await _sortTeams(listTeams);
        listTeams.add(logo);
      }

      listPlayers.add(
        PlayerEntity(
          item.text.trim(),
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

  }

  @action
  Future<String> _sortTeams( List<String> listTeams ) async {

    final random = Random();

    int totalTeams = Session.teams.length;

    TeamEntity team = Session.teams[random.nextInt(totalTeams)];

    while ( listTeams.contains(team.logo) ) {
      team = Session.teams[random.nextInt(totalTeams)];
    }

    return team.logo;
  }

  @action
  Future<List<int>> _getMatches() async {

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
  }

  @action
  void _goToBoard( TournamentEntity tournament ) {
    NavigationRoutes.navigation(NavigationTypeEnum.pop.value, "");
    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name, extra: tournament);
  }

}