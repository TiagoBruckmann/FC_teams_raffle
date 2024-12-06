// imports nativos
import 'package:flutter/material.dart';
import 'dart:math';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/db/collections/game.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/app/core/db/local_db.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'create_tournament.g.dart';

class CreateTournamentMobx extends _CreateTournamentMobx with _$CreateTournamentMobx {}

abstract class _CreateTournamentMobx with Store {

  TextEditingController eventNameController = TextEditingController();

  ObservableList<TextEditingController> playersController = ObservableList();

  @observable
  late TournamentCollection tournament;

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

    final players = await _getPlayers();
    final matches = await _getMatches(players);

    tournament = TournamentCollection(
      eventNameController.text.trim(),
      date,
      qtdDefeats,
      true,
      raffleTeams,
      createdAt,
    );

    tournament.players.toList().addAll(players);
    tournament.matches.toList().addAll(matches);

    await LocalDb().insertDb(object: tournament);

    _goToBoard();
  }

  @action
  Future<List<PlayerCollection>> _getPlayers() async {

    final List<PlayerCollection> listPlayers = [];
    final List<String> listTeams = [];

    for ( final item in playersController ) {

      String logo = "";

      if ( raffleTeams ) {
        logo = await _sortTeams(listTeams);
        listTeams.add(logo);
      }

      listPlayers.add(
        PlayerCollection(
          item.text.trim(),
          logo,
          0,
        ),
      );

    }

    listTeams.clear();

    for ( final item in listPlayers ) {
      await LocalDb().insertDb(object: item);
    }

    return listPlayers;

  }

  @action
  Future<String> _sortTeams( List<String> listTeams ) async {

    final random = Random();

    int totalTeams = Session.fcTeamCollection.teamCollection!.length;

    TeamCollection team = Session.fcTeamCollection.teamCollection![random.nextInt(totalTeams)];

    while ( listTeams.contains(team.logo) ) {
      team = Session.fcTeamCollection.teamCollection![random.nextInt(totalTeams)];
    }

    return team.logo!;
  }

  @action
  Future<List<MatchCollection>> _getMatches( List<PlayerCollection> players ) async {

    final List<MatchCollection> listMatches = [];

    final random = Random();
    int round = 1;

    while ( players.isNotEmpty ) {

      final player1 = players[random.nextInt(players.length)];
      players.removeWhere((element) => element.isEqual(player1) );
      final totalPlayers = players.length;

      PlayerCollection player2 = PlayerCollection.empty();
      if ( totalPlayers > 0 ) {
        final secondPlayer = players[random.nextInt(players.length)];
        players.removeWhere((element) => element.isEqual(secondPlayer) );
        player2 = secondPlayer;
      }

      listMatches.add(
        MatchCollection(
          player1.name,
          player2.name,
          0,
          0,
          round,
          "",
        ),
      );

      round++;

    }

    for ( final item in listMatches ) {
      await LocalDb().insertDb(object: item);
    }

    return listMatches;
  }

  @action
  void _goToBoard() {
    NavigationRoutes.navigation(NavigationTypeEnum.pop.value, "");
    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name, extra: tournament);
  }

}