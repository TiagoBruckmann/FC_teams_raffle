// import dos pacotes
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';

// import dos pacotes
import 'package:mobx/mobx.dart';

part 'board.g.dart';

class BoardMobx extends _BoardMobx with _$BoardMobx {}

abstract class _BoardMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  @action
  void selectOctaves() {}

  @action
  void selectQuarter() {}

  @action
  void selectSemi() {}

  @action
  void selectFinal() {}
  
  @action
  Future<void> getKeys( Map<String, dynamic> params ) async {

    print("params board => $params");
    final json = {
      "created_at": params["created_at"],
      "step": params["current_step"],
    };
    print("json board => $json");

    final successOrFailure = await _useCase.getKeys(json);

    successOrFailure.fold(
      (failure) => SharedServices.logError("failure_getKeys_board", message: failure.message),
      (success) => SharedServices.logSuccess("success_getKeys_board"),
    );

  }

}