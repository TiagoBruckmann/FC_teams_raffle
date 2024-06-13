// import das telas
import 'dart:math';

import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/domain/entity/key.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/session.dart';

// import dos pacotes
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'create_tournament.g.dart';

class CreateTournamentMobx extends _CreateTournamentMobx with _$CreateTournamentMobx {}

abstract class _CreateTournamentMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  TextEditingController eventNameController = TextEditingController();

  ObservableList<TextEditingController> playersController = ObservableList();

  @observable
  Map<String, dynamic> tournament = {};

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
      clear();
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
  void clear() {
    playersController.clear();
  }

  @action
  void validateFields() {

    updIsLoading(true);

    if ( eventNameController.text.trim().isEmpty || eventNameController.text.trim().length < 3 ) {
      print("Nome inválido!");
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
      print("um ou mais campos estão inválidos!");
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

    final response = await _getPlayers();

    final listKeys = response["list_keys"] as List<Map<String, dynamic>>;

    final int sizeKeys = listKeys.length;

    String step = "semi";
    if ( sizeKeys > 2 && sizeKeys <= 4 ) {
      step = "quartas";
    } else if ( sizeKeys > 4  ) {
      step = "oitavas";
    }

    tournament.addAll({
      "name": eventNameController.text.trim(),
      "date": date,
      "is_active": true,
      "defeats": qtdDefeats,
      "draw_teams": raffleTeams,
      "created_at": createdAt,
      "current_step": step,
    });

    final map = {
      "tournament": tournament,
      "players": {
        "created_at": createdAt,
        "players": response["list_players"],
      },
      "keys": {
        "step": step,
        "created_at": createdAt,
        "keys": listKeys,
      }
    };

    final successOrFailure = await _useCase.createTournament(map);

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        SharedServices.logError("failure_save_tournaments", message: failure.message);
      },
      (success) => _goToBoard(),
    );

  }

  @action
  Future<Map<String, dynamic>> _getPlayers() async {

    final List<String> listTeams = [];
    final List<Map<String, dynamic>> listPlayersMap = [];
    final List<PlayerEntity> listPlayers = [];

    for ( final item in playersController ) {

      String logo = "";

      if ( raffleTeams ) {
        logo = await _sortTeams(listTeams);
        listTeams.add(logo);
      }

      final player = PlayerEntity(
        item.text.trim(),
        logo,
        0,
      );

      listPlayers.add(player);
      listPlayersMap.add(player.toMap());
    }

    listTeams.clear();

    final listKeys = await _getKeys(listPlayers);
   listPlayers.clear();

    return {
      "list_players": listPlayersMap,
      "list_keys": listKeys,
    };
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
  Future<List<Map<String, dynamic>>> _getKeys( List<PlayerEntity> list ) async {

    final List<KeyEntity> listKeys = [];
    final List<Map<String, dynamic>> convertedList = [];

    final random = Random();
    int position = 1;

    while ( list.isNotEmpty ) {

      final player1 = list[random.nextInt(list.length)];
      list.removeWhere((element) => element.isEqual(player1) );
      final totalPlayers = list.length;

      Map<String, dynamic> player2 = {};
      if ( totalPlayers > 0 ) {
        final secondPlayer = list[random.nextInt(list.length)];
        list.removeWhere((element) => element.isEqual(secondPlayer) );
        player2.addAll(secondPlayer.toMap());
      }

      listKeys.add(
        KeyEntity(
          position,
          player1.toMap(),
          player2,
          0,
          0,
          "",
        ),
      );

      position++;
    }

    for ( final item in listKeys ) {
      convertedList.add(item.toMap());
    }

    return convertedList;
  }

  @action
  void _goToBoard() {
    NavigationRoutes.navigation(NavigationTypeEnum.pop.value, "");
    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name, extra: tournament);
  }

}