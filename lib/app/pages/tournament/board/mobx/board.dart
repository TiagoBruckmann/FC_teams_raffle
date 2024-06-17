// import dos pacotes
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/domain/entity/key.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  ObservableList<KeyEntity> listKeys = ObservableList();

  @observable
  int qtdSteps = 2;

  @action
  void selectStep( int step ) { }
  
  @action
  Future<void> getKeys( Map<String, dynamic> params ) async {

    final step = params["current_step"];

    final json = {
      "created_at": params["created_at"],
      "quantity_games": params["quantity_games"],
      "step": step,
    };

    _setSteps(step);

    final successOrFailure = await _useCase.getKeys(json);

    successOrFailure.fold(
      (failure) => SharedServices.logError("failure_getKeys_board", message: failure.message),
      (success) => _setListKeys(success),
    );

  }

  @action
  void _setSteps( String stepName ) {

    if ( stepName == "quartas" ) {
      qtdSteps = 3;
    } else if ( stepName == "oitavas" ) {
      qtdSteps = 4;
    }

  }

  @action
  void _setListKeys( List<KeyEntity> list ) {
    listKeys.clear();
    listKeys.addAll(list);
  }

  @action
  void setGoals( KeyEntity entity, { int? player1, int? player2 } ) {

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

    print("toMap => ${entity.toMap()}");

    listKeys.insert(elementIndex, entity);
  }

}