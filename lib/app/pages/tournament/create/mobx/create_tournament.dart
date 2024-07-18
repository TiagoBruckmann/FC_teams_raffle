// imports nativos
import 'package:flutter/material.dart';
import 'dart:math';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/db/collections/tournament.dart';
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'create_tournament.g.dart';

class CreateTournamentMobx extends _CreateTournamentMobx with _$CreateTournamentMobx {}

abstract class _CreateTournamentMobx with Store {

  final _useCase = TournamentUseCase(getIt());

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

    final response = await _getPlayers();

    final listPlayers = response["list_players"] as List<Map<String, dynamic>>;
    final listKeys = response["list_keys"] as List<Map<String, dynamic>>;

    final int sizeKeys = listKeys.length;

    String step = "semi";
    if ( sizeKeys > 2 && sizeKeys <= 4 ) {
      step = "quartas";
    } else if ( sizeKeys > 4  ) {
      step = "oitavas";
    }

    final mapTournament = {
      "name": eventNameController.text.trim(),
      "date": date,
      "is_active": true,
      "defeats": qtdDefeats,
      "draw_teams": raffleTeams,
      "current_step": step,
      "quantity_games": sizeKeys,
      "quantity_players": listPlayers.length,
      "created_at": createdAt,
    };

    final List<KeyCollection> keys = [];
    for ( final item in listKeys ) {
      keys.add(KeyCollection.fromJson(item));
    }

    tournament = TournamentCollection.fromJson(mapTournament, keys);

    final map = {
      "tournaments": mapTournament,
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
        Session.logs.errorLog(failure.message);
      },
      (success) => _getTournaments(),
    );

  }

  @action
  Future<Map<String, dynamic>> _getPlayers() async {

    final List<String> listTeams = [];
    final List<Map<String, dynamic>> listPlayersMap = [];
    final List<PlayerCollection> listPlayers = [];

    for ( final item in playersController ) {

      String logo = "";

      if ( raffleTeams ) {
        logo = await _sortTeams(listTeams);
        listTeams.add(logo);
      }

      final player = PlayerCollection(
        name: item.text.trim(),
        team: logo,
        defeats: 0,
      );

      listPlayers.add(player);
      listPlayersMap.add(player.toMap({}));
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
  Future<List<Map<String, dynamic>>> _getKeys( List<PlayerCollection> list ) async {

    final List<KeyCollection> listKeys = [];
    final List<Map<String, dynamic>> convertedList = [];

    final random = Random();
    int position = 1;

    while ( list.isNotEmpty ) {

      final player1 = list[random.nextInt(list.length)];
      list.removeWhere((element) => element.isEqual(player1) );
      final totalPlayers = list.length;

      PlayerCollection player2 = PlayerCollection.empty();
      if ( totalPlayers > 0 ) {
        final secondPlayer = list[random.nextInt(list.length)];
        list.removeWhere((element) => element.isEqual(secondPlayer) );
        player2 = secondPlayer;
      }

      listKeys.add(
        KeyCollection(
          position: position,
          player1: player1,
          player2: player2,
          player1Scoreboard: 0,
          player2Scoreboard: 0,
          winner: "",
        ),
      );

      position++;
    }

    for ( final item in listKeys ) {
      convertedList.add(item.toMap({}));
    }

    return convertedList;
  }

  @action
  Future<void> _getTournaments() async {

    final successOrFailure = await _useCase.getTournaments();

    successOrFailure.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) {
        Session.appEvents.sharedSuccessEvent("get_tournaments", success.toString());
        _goToBoard();
      },
    );

  }

  @action
  void _goToBoard() {
    NavigationRoutes.navigation(NavigationTypeEnum.pop.value, "");
    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name, extra: tournament);
  }

}