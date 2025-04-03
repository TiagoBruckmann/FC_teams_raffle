import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  final _tournamentUseCase = TournamentUseCase(getIt());

  final ObservableList<MatchEntity> listMatches = ObservableList();

  final ObservableList<PlayerEntity> listPlayers = ObservableList();

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
  Future<void> init( TournamentEntity tournament ) async {

    final tournamentResponse = await _getTournament(tournament.id);

    if ( tournamentResponse == null ) {
      updIsLoading(false);
      CustomSnackBar(messageKey: "pages.tournament.board.error.get_tournament");
      return NavigationRoutes.navigation(NavigationTypeEnum.pushAndRemoveUntil.value, RoutesNameEnum.home.name);
    }

    listPlayers.addAll(tournamentResponse.getPlayers);
    listMatches.addAll(tournamentResponse.getMatches);

    _tournament = TournamentEntity.fromMapper(tournamentResponse, listPlayers, listMatches);
    _setSteps();

    updIsLoading(false);

  }

  @action
  Future<TournamentEntity?> _getTournament( String tournamentId ) async {
    final response = await _tournamentUseCase.getTournamentById(tournamentId);

    return response.fold(
      (failure) {
        Session.logs.errorLog(failure.message);
        return null;
      },
      (tournament) => tournament,
    );

  }

  @action
  Future<void> setGoals( MatchEntity match, { int? score1, int? score2 } ) async {

    if ( score1 == null && score2 == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    updIsLoading(true);

    if ( score1 != null ) {
      match = match.setPlayer1Score(score1);
    }

    if ( score2 != null ) {
      match = match.setPlayer2Score(score2);
    }

    final elementIndex = listMatches.indexWhere((element) => element.isEqual(match));
    if ( elementIndex.isNegative ) {
      CustomSnackBar(messageKey: "pages.tournament.board.error.update_match");
      return;
    }

    listMatches.removeAt(elementIndex);

    if ( match.score1 != null && match.score2 != null ) {

      if ( match.score1 == match.score2 ) {
        CustomSnackBar(messageKey: "pages.tournament.board.error.equal_score");
        listMatches.insert(elementIndex, match);
        return;
      }

      final response = await match.setWinner(_tournament.id, listPlayers);
      match = response["match"] as MatchEntity;
      listPlayers.clear();
      listPlayers.addAll(response["players"] as List<PlayerEntity>);
      listPlayers.removeWhere((player) => player.getLosses >= _tournament.defeats);
    }

    listMatches.insert(elementIndex, match);

    if ( match.score1 != null && match.score2 != null ) {
      await _updNextLoserGame(match);
      await _updNextWinnerGame(match);
    }

    final response = await _tournamentUseCase.createOrUpdateMatches(_tournament.id, listMatches);

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) => Session.logs.successLog("matches_created_or_updated_with_successfully"),
    );

    listMatches.sort((a, b) => b.round.compareTo(a.round));

    if ( _tournament.hasChampion ) {

      final responseUpdTournament = await _tournamentUseCase.updateTournament(_tournament);

      responseUpdTournament.fold(
        (failure) => Session.logs.errorLog(failure.message),
        (success) => Session.logs.successLog("tournament_updated_with_successfully"),
      );
    }

    updIsLoading(false);
  }

  @action
  Future<void> _updNextWinnerGame( MatchEntity match ) async {

    String winnerName = match.player1;
    String winnerTeam = match.logoTeam1;
    String loserName = match.player2;
    String loserTeam = match.logoTeam2;

    if ( match.score2! > match.score1! ) {
      winnerName = match.player2;
      winnerTeam = match.logoTeam2;
      loserName = match.player1;
      loserTeam = match.logoTeam1;
    }

    final player1Index = listPlayers.indexWhere((player) => player.isEqualPlayerMatch(match.player1, match.logoTeam1));
    final player2Index = listPlayers.indexWhere((player) => player.isEqualPlayerMatch(match.player2, match.logoTeam2));

    final miss1Loser = ( _tournament.defeats - 1 == 0 ) ? 1 : _tournament.defeats - 1;

    bool isLoserGame = false;
    if ( !player1Index.isNegative && !player2Index.isNegative ) {
      final player1 = listPlayers[player1Index];
      final player2 = listPlayers[player2Index];

      isLoserGame = player1.getLosses >= miss1Loser && player2.getLosses >= miss1Loser;
    }

    if ( !player1Index.isNegative && player2Index.isNegative ) {
      final player1 = listPlayers[player1Index];

      isLoserGame = player1.getLosses >= miss1Loser;
    }

    if ( player1Index.isNegative && !player2Index.isNegative ) {
      final player2 = listPlayers[player2Index];

      isLoserGame = player2.getLosses >= miss1Loser;
    }

    bool hasNextWinnerPosition = false;
    final nextWinnerPosition = listMatches.indexWhere((player) => player.player2 == FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_winner"));
    final secondGame = listMatches[1];

    if ( nextWinnerPosition != -1 && ( !isLoserGame || secondGame.logoTeam2 != winnerTeam ) ) {

      hasNextWinnerPosition = true;

      final previousWinner = listMatches[nextWinnerPosition];
      listMatches.removeAt(nextWinnerPosition);

      listMatches.insert(
        nextWinnerPosition,
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          previousWinner.player1,
          previousWinner.logoTeam1,
          winnerName,
          winnerTeam,
          previousWinner.winner,
          previousWinner.round,
        ),
      );

    }

    if ( listPlayers.length > 2 && !hasNextWinnerPosition && ( !isLoserGame || secondGame.logoTeam2 != winnerTeam )) {

      final lastGameOfWinnerPlayerPosition = listMatches.indexWhere((match) => match.logoTeam1 == winnerTeam || match.logoTeam2 == winnerTeam);

      if ( !lastGameOfWinnerPlayerPosition.isNegative ) {

        final lastGameOfWinner = listMatches[lastGameOfWinnerPlayerPosition];

        if ( lastGameOfWinner.score1 == null || lastGameOfWinner.score2 == null ) {
          return;
        }
      }

      final emptyPlayer = PlayerEntity.nextWinner();

      listMatches.add(
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          winnerName,
          winnerTeam,
          emptyPlayer.name,
          emptyPlayer.team,
          "",
          listMatches.length + 1,
        ),
      );

      return;
    }

    int qtdLosses = _tournament.defeats;
    final loserIndex = listPlayers.indexWhere((player) => player.isEqualPlayerMatch(loserName, loserTeam));
    if ( loserIndex != -1 ) {
      qtdLosses = listPlayers[loserIndex].getLosses;
    }

    if ( listPlayers.length == 2 && qtdLosses < _tournament.defeats ) {
      listMatches.add(
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          winnerName,
          winnerTeam,
          loserName,
          loserTeam,
          "",
          listMatches.length + 1,
        ),
      );

      return;
    }

    if ( listPlayers.length == 2 && !nextWinnerPosition.isNegative ) {
      final previousWinner = listMatches[nextWinnerPosition];
      listMatches.removeAt(nextWinnerPosition);

      listMatches.add(
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          previousWinner.player1,
          previousWinner.logoTeam1,
          winnerName,
          winnerTeam,
          "",
          listMatches.length + 1,
        ),
      );

      return;
    }

    if ( listPlayers.length == 1 ) {
      final winner = PlayerEntity.champion();

      final hasChampion = listMatches.where((match) => match.player2.toLowerCase() == winner.name.toLowerCase());

      if ( hasChampion.isNotEmpty ) {
        return;
      }

      listMatches.add(
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          winnerName,
          winnerTeam,
          winner.name,
          winner.team,
          "",
          listMatches.length + 1,
        ),
      );

      _tournament = _tournament.updChampion();

      return;
    }

  }

  @action
  Future<void> _updNextLoserGame( MatchEntity match ) async {

    String winnerName = match.player1;
    String winnerTeam = match.logoTeam1;
    String loserName = match.player2;
    String loserTeam = match.logoTeam2;

    if ( match.score2! > match.score1! ) {
      winnerName = match.player2;
      winnerTeam = match.logoTeam2;
      loserName = match.player1;
      loserTeam = match.logoTeam1;
    }

    int qtdLosses = _tournament.defeats;
    final loserIndex = listPlayers.indexWhere((player) => player.isEqualPlayerMatch(loserName, loserTeam));
    if ( loserIndex != -1 ) {
      qtdLosses = listPlayers[loserIndex].getLosses;
    }

    bool hasNextLoserPosition = false;
    final nextLoserPosition = listMatches.indexWhere((player) => player.player2 == FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_loser"));
    if ( nextLoserPosition != -1 ) {
      hasNextLoserPosition = true;

      final emptyPLayer = listMatches[nextLoserPosition];
      listMatches.removeAt(nextLoserPosition);

      if ( qtdLosses >= _tournament.defeats ) {
        loserName = winnerName;
        loserTeam = winnerTeam;
      }

      listMatches.insert(
        nextLoserPosition,
        MatchEntity(
          emptyPLayer.id,
          emptyPLayer.player1,
          emptyPLayer.logoTeam1,
          loserName,
          loserTeam,
          emptyPLayer.winner,
          emptyPLayer.round,
        ),
      );

    }

    if ( listPlayers.length > 2 && !hasNextLoserPosition && qtdLosses < _tournament.defeats ) {

      final emptyPlayer = PlayerEntity.nextLoser();

      listMatches.add(
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          loserName,
          loserTeam,
          emptyPlayer.name,
          emptyPlayer.team,
          "",
          listMatches.length + 1,
        ),
      );

      return;
    }

    if ( listPlayers.length == 1 ) {
      final winner = PlayerEntity.champion();

      final hasChampion = listMatches.where((match) => match.player2.toLowerCase() == winner.name.toLowerCase());

      if ( hasChampion.isNotEmpty ) {
        return;
      }

      listMatches.add(
        MatchEntity(
          Session.sharedServices.getRandomString(20),
          winnerName,
          winnerTeam,
          winner.name,
          winner.team,
          "",
          listMatches.length + 1,
        ),
      );

      _tournament = _tournament.updChampion();

      return;
    }

  }

}