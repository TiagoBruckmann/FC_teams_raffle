// import das telas
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
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

  final _tournamentUseCase = TournamentUseCase(getIt());

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

    if ( _tournament.playerId.length > 4 || _tournament.playerId.length < 8 ) {
      qtdSteps = 3;
    } if ( _tournament.playerId.length > 8 ) {
      qtdSteps = 4;
    }

  }

  @action
  Future<void> setListKeys( TournamentEntity tournament ) async {
    _tournament = tournament;
    _setSteps();

    if ( tournament.matchId.isEmpty ) {
      return;
    }

    await _getPlayers();
    await _getMatches();

    updIsLoading(false);

  }

  Future<void> _getPlayers() async {
    final response = await _tournamentUseCase.getPlayers();

    final List<PlayerEntity> players = [];

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (player) => players.addAll(player),
    );

    players.retainWhere((player) => _tournament.playerId.contains(player.id.toString()));

    listPlayers.addAll(players);
    return;
  }

  Future<void> _getMatches() async {
    final response = await _tournamentUseCase.getMatches();

    final List<MatchEntity> matches = [];

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (match) => matches.addAll(match),
    );

    matches.retainWhere((match) => _tournament.matchId.contains(match.id.toString()));

    listMatches.addAll(matches);
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

      if ( _tournament.matchId.isNotEmpty ) {
        _tournament.matchId.clear();
      }

      final List<String> matchesId = [];
      for ( final match in listMatches ) {
        matchesId.add((match.id ?? 1).toString());
      }

      _tournament.matchId.addAll(matchesId);

    }

    updIsLoading(false);
  }

}