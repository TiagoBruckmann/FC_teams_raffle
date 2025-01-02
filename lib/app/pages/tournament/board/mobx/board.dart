// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
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

    if ( _tournament.getPlayers.length > 4 || _tournament.getPlayers.length < 8 ) {
      qtdSteps = 3;
    } if ( _tournament.getPlayers.length > 8 ) {
      qtdSteps = 4;
    }

  }

  @action
  Future<void> init( TournamentEntity tournament ) async {

    print("tournament => $tournament");
    int tournamentId = tournament.id ?? 1;

    print("tournamentId => $tournamentId");
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
      final response = await match.setWinner(listPlayers);
      print("response => $response");
      match = response["match"] as MatchEntity;
      print("match => $match");
      listPlayers.clear();
      listPlayers.addAll(response["players"] as List<PlayerEntity>);
      print("listPlayers => $listPlayers");
    }

    listMatches.insert(elementIndex, match);

    if ( match.score1 != null && match.score2 != null ) {
      await _updNextWinnerGame(match);
    }

    updIsLoading(false);
  }

  Future<void> _updNextWinnerGame( MatchEntity match ) async {

    String winnerName = match.player1;
    String winnerTeam = match.logoTeam1;

    if ( match.score2! > match.score1! ) {
      winnerName = match.player2;
      winnerTeam = match.logoTeam2;
    }

    bool hasNextWinnerPosition = false;
    final nextWinnerPosition = listMatches.indexWhere((player) => player.player2 == "Próximo ganhador");
    if ( nextWinnerPosition != -1 ) {
      hasNextWinnerPosition = true;

      final emptyPLayer = listMatches[nextWinnerPosition];
      listMatches.removeAt(nextWinnerPosition);

      listMatches.insert(
        nextWinnerPosition,
        MatchEntity(
          id: emptyPLayer.id,
          emptyPLayer.player1,
          emptyPLayer.logoTeam1,
          winnerName,
          winnerTeam,
          emptyPLayer.winner,
          emptyPLayer.round,
        ),
      );

    }

    final List<PlayerEntity> players = List.from(listPlayers);
    print("players.length 1 => ${players.length}");
    players.retainWhere((player) => player.losses < _tournament.defeats);
    print("players.length 2 => ${players.length}");
    print("hasNextWinnerPosition => $hasNextWinnerPosition");

    if ( players.length >= 2 && !hasNextWinnerPosition ) {

      final emptyPlayer = PlayerEntity.empty();

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
    }

    if ( players.length == 1 ) {
      final winner = PlayerEntity.winner();

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
    }

    final response = await _tournamentUseCase.updateMatches(listMatches);
    print("response => $response");

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) => success,
    );

  }

}