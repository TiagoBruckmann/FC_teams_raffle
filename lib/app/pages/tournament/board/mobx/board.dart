// import das telas
import 'package:fc_teams_drawer/app/core/db/collections/game.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  ObservableList<MatchCollection> listMatches = ObservableList();

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
  void _setSteps() {

    if ( _tournament.players.toList().length > 4 || _tournament.players.toList().length < 8 ) {
      qtdSteps = 3;
    } if ( _tournament.players.length > 8 ) {
      qtdSteps = 4;
    }

  }

  @action
  Future<void> setListKeys( TournamentCollection tournament ) async {
    _tournament = tournament;
    _setSteps();

    if ( tournament.matches.toList().isEmpty ) {
      return;
    }

    listMatches.addAll(tournament.matches.toList());
    listPlayers.addAll(tournament.players.toList());

    updIsLoading(false);

  }

  @action
  Future<void> setGoals( MatchCollection match, { int? score1, int? score2 } ) async {

    if ( score1 == null && score2 == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    updIsLoading(true);

    score1 = score1 ?? match.score1;
    score2 = score2 ?? match.score2;

    if ( score1 != null ) {
      match.setPlayer1Goals(score1);
    }

    if ( score2 != null ) {
      match.setPlayer2Goals(score2);
    }
    
    final elementIndex = listMatches.indexWhere((element) => element.player1 == match.player1 && element.player2 == match.player2 && element.score1 == score1 && element.score2 == score2);
    listMatches.removeAt(elementIndex);

    match.setWinner();

    listMatches.insert(elementIndex, match);

    if ( match.score1 != null && match.score2 != null ) {

      String player = match.player1;
      if ( match.score2! < match.score1! ) {
        player = match.player2;
      }

      final loserIndex = listPlayers.indexWhere((element) => element.name.contains(player));
      listPlayers.removeAt(loserIndex);

      final entity = listPlayers[loserIndex];
      entity.updDefeats();

      listPlayers.insert(loserIndex, entity);
      listPlayers.removeWhere((element) => element.losses >= _tournament.defeats );

      if ( _tournament.matches.toList().isNotEmpty ) {
        _tournament.matches.toList().clear();
      }

      _tournament.matches.toList().addAll(listMatches);

    }

    updIsLoading(false);
  }

}