// import das telas
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  ObservableList<MatchEntity> listMatches = ObservableList();

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
  void _setSteps() {

    if ( _tournament.getPlayers.length > 4 || _tournament.getPlayers.length < 8 ) {
      qtdSteps = 3;
    } if ( _tournament.getPlayers.length > 8 ) {
      qtdSteps = 4;
    }

  }

  @action
  Future<void> setListKeys( TournamentEntity tournament ) async {
    _tournament = tournament;
    _setSteps();

    if ( tournament.getMatches.isEmpty ) {
      return;
    }

    await _getPlayers();
    await _getMatches();

    updIsLoading(false);

  }

  Future<void> _getPlayers() async {
    listPlayers.addAll(_tournament.getPlayers);
    return;
  }

  Future<void> _getMatches() async {
    listMatches.addAll(_tournament.getMatches);
    return;
  }

  @action
  Future<void> setGoals( MatchEntity match, { int? score1, int? score2 } ) async {

    if ( score1 == null && score2 == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    updIsLoading(true);

    score1 = score1 ?? match.score1;
    score2 = score2 ?? match.score2;

    if ( score1 > 0 ) {
      match.setPlayer1Score(score1);
    }

    if ( score2 > 0 ) {
      match.setPlayer2Score(score2);
    }
    
    final elementIndex = listMatches.indexWhere((element) => element.player1 == match.player1 && element.player2 == match.player2 && element.score1 == score1 && element.score2 == score2);
    listMatches.removeAt(elementIndex);

    match.setWinner();

    listMatches.insert(elementIndex, match);

    if ( match.score1 != 0 && match.score2 != 0 ) {

      String playerLoser = match.player1;
      if ( match.score2 < match.score1 ) {
        playerLoser = match.player2;
      }

      final loserIndex = listPlayers.indexWhere((element) => element.name.contains(playerLoser));
      listPlayers.removeAt(loserIndex);

      final loserEntity = listPlayers[loserIndex].setLoser();

      listPlayers.insert(loserIndex, loserEntity);
      listPlayers.removeWhere((element) => element.losses >= _tournament.defeats );

    }

    updIsLoading(false);
  }

}