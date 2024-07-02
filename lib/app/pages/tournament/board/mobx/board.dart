// import das telas
import 'package:fc_teams_drawer/app/core/db/collections/tournament.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/session.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  ObservableList<KeyCollection> listKeys = ObservableList();

  ObservableList<PlayerCollection> listPlayers = ObservableList();

  @observable
  bool isLoading = true;

  @observable
  late TournamentCollection _tournament;

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
  Future<void> setListKeys( TournamentCollection tournament ) async {
    _tournament = tournament;
    _setSteps(tournament.currentStep!);

    if ( tournament.listKeys != null && tournament.listKeys!.isEmpty ) {
      return;
    }

    listKeys.addAll(tournament.listKeys!);

    int position = 0;
    while ( listPlayers.length < _tournament.quantityPlayers! ) {

      if ( !listPlayers.contains(listKeys[position].player1!) ) {
        listPlayers.add(
          PlayerCollection.fromJson(listKeys[position].player1!.toMap({})),
        );
      }

      if ( listKeys[position].player2?.team != null && !listPlayers.contains(listKeys[position].player2!) ) {
        listPlayers.add(
          PlayerCollection.fromJson(listKeys[position].player2!.toMap({})),
        );
      }

      position++;

    }

    updIsLoading(false);

  }

  @action
  Future<void> setGoals( KeyCollection keyCollection, { int? player1ScoreBoard, int? player2ScoreBoard } ) async {

    if ( player1ScoreBoard == null && player2ScoreBoard == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    updIsLoading(true);

    player1ScoreBoard = player1ScoreBoard ?? keyCollection.player1Scoreboard;
    player2ScoreBoard = player2ScoreBoard ?? keyCollection.player2Scoreboard;

    if ( player1ScoreBoard != null ) {
      keyCollection.setPlayer1Goals(player1ScoreBoard);
    }

    if ( player2ScoreBoard != null ) {
      keyCollection.setPlayer2Goals(player2ScoreBoard);
    }
    
    final elementIndex = listKeys.indexWhere((element) => element.player1 == keyCollection.player1 && element.player2 == keyCollection.player2 && element.player1Scoreboard == player1ScoreBoard && element.player2Scoreboard == player2ScoreBoard);
    listKeys.removeAt(elementIndex);

    keyCollection.setWinner();

    listKeys.insert(elementIndex, keyCollection);

    if ( keyCollection.player1Scoreboard != null && keyCollection.player2Scoreboard != null ) {

      PlayerCollection player = keyCollection.player1!;
      if ( keyCollection.player2Scoreboard! < keyCollection.player1Scoreboard! ) {
        player = keyCollection.player2!;
      }

      final loserIndex = listPlayers.indexWhere((element) => element.isEqual(player));
      listPlayers.removeAt(loserIndex);

      listPlayers.insert(loserIndex, player);
      listPlayers.removeWhere((element) => element.defeats! >= _tournament.defeats!);

      if ( _tournament.listKeys != null && _tournament.listKeys!.isNotEmpty ) {
        _tournament.listKeys?.clear();
      }

      _tournament.listKeys?.addAll(listKeys);

      return await _updWinner(keyCollection);
    }

    updIsLoading(false);
  }

  @action
  Future<void> _updWinner( KeyCollection keyCollection ) async {

    final index = Session.gamesCollection.listTournaments?.indexWhere((element) => element.listKeys!.contains(keyCollection)) ?? 0;
    Session.gamesCollection.listTournaments?.removeAt(index);

    Session.gamesCollection.listTournaments?.insert(index, _tournament);

    final successOrFailure = await _useCase.updAllKey( Session.gamesCollection );

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        CustomSnackBar(messageKey: failure.message);
      },
      (success) {
        Session.logs.successLog("key_winner_${keyCollection.winner}");
        _validateRound(keyCollection);
      },
    );

  }

  @action
  Future<void> _validateRound( KeyCollection keyCollection ) async {

    String step = "final";
    if ( listPlayers.length > 2 && listPlayers.length < 5 ) {
      step = "semi";
    } else if ( listPlayers.length > 4 && listPlayers.length < 9 ) {
      step = "quartas";
    } else if ( listPlayers.length > 8 ) {
      step = "oitavas";
    }

    final mugPLayer = listKeys.last;

    PlayerCollection winner = keyCollection.player1!;
    if ( keyCollection.player2Scoreboard! > keyCollection.player1Scoreboard! ) {
      winner = keyCollection.player2!;
    }

    PlayerCollection? emptyPlayer;

    if ( mugPLayer.player2 != null ) {

      final map = {
        "position": mugPLayer.position,
        "player1": mugPLayer.player1,
        "player2": winner,
        "player1_scoreboard": 0,
        "player2_scoreboard": 0,
        "winner": "",
      };

      KeyCollection key = KeyCollection.fromJson(map);

      await _updSecondPLayer(key);

      PlayerCollection loser = keyCollection.player1!;
      if ( keyCollection.player2Scoreboard! < keyCollection.player1Scoreboard! ) {
        loser = keyCollection.player2!;
      }

      final loserMap = {
        "created_at": _tournament.createdAt,
        "step": step,
        "position": listKeys.length + 1,
        "player1": loser,
        "player2": emptyPlayer,
        "player1_scoreboard": 0,
        "player2_scoreboard": 0,
        "winner": "",
      };

      KeyCollection loserKey = KeyCollection.fromJson(loserMap);

      return await _createNewKey(loserKey);
    }

    final winnerMap = {
      "created_at": _tournament.createdAt,
      "step": step,
      "position": listKeys.length + 1,
      "player1": winner,
      "player2": emptyPlayer,
      "player1_scoreboard": 0,
      "player2_scoreboard": 0,
      "winner": "",
    };
    KeyCollection winnerKey = KeyCollection.fromJson(winnerMap);

    return await _createNewKey(winnerKey);

  }

  @action
  Future<void> _updSecondPLayer( KeyCollection key ) async {

    for ( final tournaments in Session.gamesCollection.listTournaments! ) {
      for ( final key in tournaments.listKeys! ) {
        if ( key.isEqual(key) ) {
          key.setPlayer2( key.player2! );
        }
      }
    }

    final successOrFailure = await _useCase.updAllKey( Session.gamesCollection );

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        CustomSnackBar(messageKey: failure.message);
      },
      (success) {
        Session.logs.successLog("second_player_updated");
        final gamePosition = listKeys.indexWhere((element) => element.position == key.position);
        listKeys.removeAt(gamePosition);
        listKeys.insert(gamePosition, key);

        updIsLoading(false);
      },
    );

  }

  @action
  Future<void> _createNewKey( KeyCollection key ) async {

    final index = Session.gamesCollection.listTournaments!.indexWhere((element) => element.createdAt == _tournament.createdAt);
    Session.gamesCollection.listTournaments!.removeAt(index);

    _tournament.listKeys!.add(key);

    Session.gamesCollection.listTournaments!.insert(index, _tournament);

    final successOrFailure = await _useCase.updAllKey( Session.gamesCollection );

    successOrFailure.fold(
      (failure) {
        updIsLoading(false);
        CustomSnackBar(messageKey: failure.message);
      },
      (success) {
        Session.logs.successLog("create_new_key");
        updIsLoading(false);
      },
    );

  }

}