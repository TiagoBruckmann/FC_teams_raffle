// import das telas
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/key.dart';
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

    await Future.delayed(const Duration(seconds: 1));
  }

  @action
  Future<void> setGoals( KeyEntity entity, Map<String, dynamic> map, { int? player1, int? player2 } ) async {

    if ( player1 == null && player2 == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.invalid_score");
      return;
    }

    player1 = player1 ?? entity.player1Scoreboard;
    player2 = player2 ?? entity.player2Scoreboard;

    if ( player1 != null ) {
      entity.setPlayer1Goals(player1);
    }

    if ( player2 != null ) {
      entity.setPlayer2Goals(player2);
    }
    
    final elementIndex = listKeys.indexWhere((element) => element.player1 == entity.player1 && element.player2 == entity.player2);
    listKeys.removeAt(elementIndex);

    entity.setWinner();

    listKeys.insert(elementIndex, entity);

    if ( entity.player1Scoreboard != null && entity.player2Scoreboard != null ) {
      await _updGame(entity.toMap(map));
    }

  }

  Future<void> _updGame( Map<String, dynamic> json ) async {

    final successOrFailure = await _useCase.updKey( json );

    successOrFailure.fold(
      (failure) => CustomSnackBar(messageKey: failure.message),
      (success) => Session.logs.successLog("key_winner_${json["winner"]}"),
    );

  }

  void _validateKey() {

    if ( _tournament.quantityPlayers == 3 ) {

    }

  }

  Future<void> _updKey() async {

  }

}