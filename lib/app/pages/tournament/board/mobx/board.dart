// import das telas
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/session.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/key.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  ObservableList<KeyEntity> listKeys = ObservableList();

  ObservableList<PlayerEntity> listPlayers = ObservableList();

  @observable
  bool isLoading = true;

  @observable
  late TournamentEntity _tournament;

  @observable
  int selectedStep = 2;

  @observable
  int qtdSteps = 2;

  @action
  void updIsLoading( bool value ) => isLoading = value;

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

    updIsLoading(false);

  }

  @action
  Future<void> setGoals( KeyEntity entity, Map<String, dynamic> map, { int? player1ScoreBoard, int? player2ScoreBoard } ) async {

    if ( player1ScoreBoard == null && player2ScoreBoard == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    updIsLoading(true);

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
      listPlayers.removeWhere((element) => element.defeats >= _tournament.defeats);

      return await _updWinner(entity.toMap(map));
    }

    updIsLoading(false);
  }

  @action
  Future<void> _updWinner( Map<String, dynamic> json ) async {

    final successOrFailure = await _useCase.updWinner( json );

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        CustomSnackBar(messageKey: failure.message);
      },
      (success) {
        Session.logs.successLog("key_winner_${json["winner"]}");
        _validateRound(json);
      },
    );

  }

  @action
  Future<void> _validateRound( Map<String, dynamic> json ) async {

    String step = "final";
    if ( listPlayers.length > 2 && listPlayers.length < 5 ) {
      step = "semi";
    } else if ( listPlayers.length > 4 && listPlayers.length < 9 ) {
      step = "quartas";
    } else if ( listPlayers.length > 8 ) {
      step = "oitavas";
    }

    final mugPLayer = listKeys.last;

    Map<String, dynamic> winner = json["player1"];
    if ( json["player2_scoreboard"] > json["player1_scoreboard"] ) {
      winner = json["player2"];
    }

    final Map<String, dynamic> emptyPlayer = {};

    if ( mugPLayer.player2.isEmpty ) {

      final map = {
        "created_at": json["created_at"],
        "step": step,
        "position": mugPLayer.position,
        "player1": mugPLayer.player1,
        "player2": winner,
        "player1_scoreboard": 0,
        "player2_scoreboard": 0,
        "winner": "",
      };

      await _updSecondPLayer(map);

      Map<String, dynamic> loser = json["player1"];
      if ( json["player2_scoreboard"] < json["player1_scoreboard"] ) {
        winner = json["player2"];
      }

      final loserMap = {
        "created_at": json["created_at"],
        "step": step,
        "position": listKeys.length + 1,
        "player1": loser,
        "player2": emptyPlayer,
        "player1_scoreboard": 0,
        "player2_scoreboard": 0,
        "winner": "",
      };

      return await _createNewKey(loserMap);
    }

    final winnerMap = {
      "created_at": json["created_at"],
      "step": step,
      "position": listKeys.length + 1,
      "player1": winner,
      "player2": emptyPlayer,
      "player1_scoreboard": 0,
      "player2_scoreboard": 0,
      "winner": "",
    };

    return await _createNewKey(winnerMap);

  }

  @action
  Future<void> _updSecondPLayer( Map<String, dynamic> player ) async {

    final successOrFailure = await _useCase.updSecondPLayer( player );

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        CustomSnackBar(messageKey: failure.message);
      },
      (success) {
        Session.logs.successLog("second_player_updated");
        final gamePosition = listKeys.indexWhere((element) => element.position == player["position"]);
        listKeys.removeAt(gamePosition);
        listKeys.insert(gamePosition, KeyEntity.fromJson(player));

        updIsLoading(false);
      },
    );

  }

  @action
  Future<void> _createNewKey( Map<String, dynamic> player ) async {

    final successOrFailure = await _useCase.createNewKey( player );

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        CustomSnackBar(messageKey: failure.message);
      },
      (success) {
        Session.logs.successLog("create_new_key");
        listKeys.add(success);
        updIsLoading(false);
      },
    );

  }

}