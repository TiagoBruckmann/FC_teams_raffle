// import das telas
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/key.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/session.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  ObservableList<KeyEntity> listKeys = ObservableList();

  ObservableList<PlayerEntity> listPlayers = ObservableList();

  @observable
  late TournamentEntity _tournament;

  @observable
  int selectedStep = 2;

  @observable
  int qtdSteps = 2;

  @action
  void selectStep( int step ) => selectedStep = step;

  @action
  void _setSteps( String stepName ) {

    if ( stepName == "quartas" ) {
      qtdSteps = 3;
    } else if ( stepName == "oitavas" ) {
      qtdSteps = 4;
    }

  }

  @action
  Future<void> setListKeys( TournamentEntity tournament ) async {
    _tournament = tournament;
    _setSteps(tournament.currentStep);

    if ( tournament.listKeys.isEmpty ) {
      return;
    }

    listKeys.addAll(tournament.listKeys);

    int position = 0;
    while ( listPlayers.length < _tournament.quantityPlayers ) {

      if ( !listPlayers.contains(listKeys[position].player1["team"]) ) {
        listPlayers.add(
          PlayerEntity.fromJson(listKeys[position].player1),
        );
      }

      if ( listKeys[position].player2["team"] != null && !listPlayers.contains(listKeys[position].player2["team"]) ) {
        listPlayers.add(
          PlayerEntity.fromJson(listKeys[position].player2),
        );
      }

      position++;

    }

  }

  @action
  Future<void> setGoals( KeyEntity entity, Map<String, dynamic> map, { int? player1ScoreBoard, int? player2ScoreBoard } ) async {

    if ( player1ScoreBoard == null && player2ScoreBoard == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    player1ScoreBoard = player1ScoreBoard ?? entity.player1Scoreboard;
    player2ScoreBoard = player2ScoreBoard ?? entity.player2Scoreboard;

    if ( player1ScoreBoard != null ) {
      entity.setPlayer1Goals(player1ScoreBoard);
    }

    if ( player2ScoreBoard != null ) {
      entity.setPlayer2Goals(player2ScoreBoard);
    }
    
    final elementIndex = listKeys.indexWhere((element) => element.player1 == entity.player1 && element.player2 == entity.player2 && element.player1Scoreboard == player1ScoreBoard && element.player2Scoreboard == player2ScoreBoard);
    listKeys.removeAt(elementIndex);

    entity.setWinner();

    listKeys.insert(elementIndex, entity);

    if ( entity.player1Scoreboard != null && entity.player2Scoreboard != null ) {

      Map<String, dynamic> player = entity.player1;
      if ( entity.player2Scoreboard! < entity.player1Scoreboard! ) {
        player = entity.player2;
      }

      final loserIndex = listPlayers.indexWhere((element) => element.team.contains(player["team"]));
      listPlayers.removeAt(loserIndex);

      listPlayers.insert(loserIndex, PlayerEntity.fromJson(player));
      await _updWinner(entity.toMap(map));
    }

  }

  @action
  Future<void> _updWinner( Map<String, dynamic> json ) async {

    final successOrFailure = await _useCase.updWinner( json );

    successOrFailure.fold(
      (failure) => CustomSnackBar(messageKey: failure.message),
      (success) {
        Session.logs.successLog("key_winner_${json["winner"]}");
        _validateKey( json );
      },
    );

  }

  @action
  void _validateKey( Map<String, dynamic> json ) {

    print("antes jogadores => ${listPlayers.length}");
    listPlayers.removeWhere((element) => element.defeats >= 2);
    print("restam jogadores => ${listPlayers.length}");

    listPlayers.forEach((p) => print("${p.name} => ${p.defeats} derrotas"));

    String step = "final";
    if ( listPlayers.length > 2 && listPlayers.length <= 4 ) {
      step = "semi";
    } else if ( listPlayers.length > 4 && listPlayers.length <= 8 ) {
      step = "quartas";
    } else {
      step = "oitavas";
    }

    final map = {
      "step": step,
    };

    // _updKey();

  }

  @action
  Future<void> _updKey() async {

  }

}