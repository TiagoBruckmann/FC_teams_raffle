// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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

    if ( _tournament.getPlayers.length > 4 || _tournament.getPlayers.length < 8 ) {
      qtdSteps = 3;
    } if ( _tournament.getPlayers.length > 8 ) {
      qtdSteps = 4;
    }

  }

  @action
  Future<void> init( TournamentEntity tournament ) async {

    int tournamentId = tournament.id ?? 1;

    final tournamentResponse = await _getTournament(tournamentId);

    if ( tournamentResponse == null ) {
      updIsLoading(false);
      CustomSnackBar(messageKey: "pages.tournament.board.error.get_tournament");
      return NavigationRoutes.navigation(NavigationTypeEnum.pushAndRemoveUntil.value, RoutesNameEnum.home.name);
    }

    listPlayers.addAll(tournament.getPlayers);
    listMatches.addAll(tournament.getMatches);

    _tournament = TournamentEntity.fromMapper(tournamentResponse, listPlayers, listMatches);
    _setSteps();

    updIsLoading(false);

  }

  @action
  Future<TournamentEntity?> _getTournament( int tournamentId ) async {
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

      final response = await match.setWinner(listPlayers);
      match = response["match"] as MatchEntity;
      listPlayers.clear();
      listPlayers.addAll(response["players"] as List<PlayerEntity>);
    }

    listMatches.insert(elementIndex, match);

    if ( match.score1 != null && match.score2 != null ) {
      await _updNextLoserGame(match);
      await _updNextWinnerGame(match);
    }

    final response = await _tournamentUseCase.createOrUpdateMatches(listMatches);

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (ids) async => await _updateTournament(ids),
    );

    listMatches.sort((a, b) => b.round.compareTo(a.round));

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
    if ( nextWinnerPosition != -1 && !isLoserGame ) {
      hasNextWinnerPosition = true;

      final previousWinner = listMatches[nextWinnerPosition];
      listMatches.removeAt(nextWinnerPosition);

      listMatches.insert(
        nextWinnerPosition,
        MatchEntity(
          previousWinner.player1,
          previousWinner.logoTeam1,
          winnerName,
          winnerTeam,
          previousWinner.winner,
          previousWinner.round,
        ),
      );

    }

    listPlayers.removeWhere((player) => player.getLosses >= _tournament.defeats);

    if ( listPlayers.length > 2 && !hasNextWinnerPosition && !isLoserGame ) {

      final emptyPlayer = PlayerEntity.nextWinner();

      listMatches.add(
        MatchEntity(
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
          winnerName,
          winnerTeam,
          winner.name,
          winner.team,
          "",
          listMatches.length + 1,
        ),
      );

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
          id: emptyPLayer.id,
          emptyPLayer.player1,
          emptyPLayer.logoTeam1,
          loserName,
          loserTeam,
          emptyPLayer.winner,
          emptyPLayer.round,
        ),
      );

    }

    listPlayers.removeWhere((player) => player.getLosses >= _tournament.defeats);

    if ( listPlayers.length > 2 && !hasNextLoserPosition && qtdLosses < _tournament.defeats ) {

      final emptyPlayer = PlayerEntity.nextLoser();

      listMatches.add(
        MatchEntity(
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
          winnerName,
          winnerTeam,
          winner.name,
          winner.team,
          "",
          listMatches.length + 1,
        ),
      );

      return;
    }

  }

  @action
  Future<void> _updateTournament( List<int> matchesIds ) async {

    final List<int> playersIds = [];

    for ( final player in listPlayers ) {
      if ( player.id != null ) {
        playersIds.add(player.id!);
      }
    }

    final List<TournamentMapperEntity> tournamentMapperList = [];

    for ( final playerId in playersIds ) {
      tournamentMapperList.add(
        TournamentMapperEntity.fromPlayerId(_tournament.id!, playerId),
      );
    }

    for ( final matchId in matchesIds ) {
      tournamentMapperList.add(
        TournamentMapperEntity.fromMatchId(_tournament.id!, matchId),
      );
    }

    final response = await _tournamentUseCase.createOrUpdateTournamentMapper(tournamentMapperList);

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) => success,
    );

  }

}