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
  Future<void> init( List<TournamentMapperEntity> mappers ) async {

    print("mappers => $mappers");
    int tournamentId = mappers.first.id ?? mappers.first.tournamentId;
    final List<int> playersIds = [];
    final List<int> matchesIds = [];
    for ( final mapper in mappers ) {

      print("mapper.id => ${mapper.id}");
      print("mapper.tournamentId => ${mapper.tournamentId}");
      if ( tournamentId == 0 ) {
        tournamentId = mapper.id ?? 0;
      }

      print("mapper.playerId => ${mapper.playerId}");
      if ( mapper.playerId != null ) {
        playersIds.add(mapper.playerId!);
      }

      print("mapper.matchId => ${mapper.matchId}");
      if ( mapper.matchId != null ) {
        matchesIds.add(mapper.matchId!);
      }

    }

    print("tournamentId => $tournamentId");
    final tournament = await _getTournament(tournamentId);

    if ( tournament == null ) {
      updIsLoading(false);
      CustomSnackBar(messageKey: "pages.tournament.board.error.get_tournament");
      return NavigationRoutes.navigation(NavigationTypeEnum.pushAndRemoveUntil.value, RoutesNameEnum.home.name);
    }

    await _getPlayers(playersIds);
    await _getMatches(matchesIds);

    _tournament = TournamentEntity.fromMapper(tournament, listPlayers, listMatches);
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
  Future<void> _getPlayers( List<int> players ) async {
    final response = await _tournamentUseCase.getPlayers();

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (list) {
        list.retainWhere((player) => players.contains(player.id));
        listPlayers.addAll(list);
      },
    );

    return;
  }

  @action
  Future<void> _getMatches( List<int> matches ) async {
    final response = await _tournamentUseCase.getMatches();

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (list) {
        list.retainWhere((match) => matches.contains(match.id));
        listMatches.addAll(list);
      },
    );

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
    
    final elementIndex = listMatches.indexWhere((element) => element.isEqual(match));
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