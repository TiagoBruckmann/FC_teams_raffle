// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';

// import dos pacotes
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'create_tournament.g.dart';

class CreateTournamentMobx extends _CreateTournamentMobx with _$CreateTournamentMobx {}

abstract class _CreateTournamentMobx with Store {

  final _useCase = TournamentUseCase(getIt());

  TextEditingController eventNameController = TextEditingController();

  ObservableList<TextEditingController> playersController = ObservableList();

  @observable
  bool isLoading = true;

  @observable
  int qtdPlayers = 0;

  @observable
  int qtdDefeats = 0;

  @observable
  bool raffleTeams = true;

  @action
  void initialSettings() {
    setQtdPlayers(3);
    setQtdDefeats(2);
    updIsLoading(false);
  }

  @action
  void updIsLoading( bool value ) => isLoading = value;

  @action
  void setQtdPlayers( int value ) {

    if ( playersController.isNotEmpty ) {
      clear();
    }

    while ( playersController.length < value ) {
      playersController.add(
        TextEditingController(),
      );
    }

    qtdPlayers = value;
  }

  @action
  void setQtdDefeats( int value ) => qtdDefeats = value;

  @action
  void updRaffleTeams() => raffleTeams = !raffleTeams;

  @action
  void clear() {
    playersController.clear();
  }

  @action
  void validateFields() {

    if ( eventNameController.text.trim().isEmpty || eventNameController.text.trim().length < 3 ) {
      print("Nome inválido!");
      return;
    }

    bool isValidText = true;
    for ( final item in playersController ) {

      if ( item.text.trim().isEmpty || item.text.trim().length < 3 ) {
        print("item => ${item.text}");
        isValidText = false;
      }

    }

    if ( !isValidText ) {
      print("um ou mais campos estão inválidos!");
      return;
    }

    _saveTournament();
    return;
  }

  @action
  Future<void> _saveTournament() async {

    final dateNow = DateTime.now();
    final day = SharedServices.convertDate(dateNow.day);
    final month = SharedServices.convertDate(dateNow.month);

    final date = "$day/$month/${dateNow.year}";
    final createdAt = DateFormat("yyyyMMddkkmmss").format(dateNow);

    final map = {
      "name": eventNameController.text.trim(),
      "is_active": true,
      "date": date,
      "created_at": createdAt,
    };

    print("map => $map");

    final successOrFailure = await _useCase.createTournament(map);

    successOrFailure.fold(
      (failure) => SharedServices.logError("failure_save_tournaments", message: failure.message),
      (success) => _goToBoard(),
    );

  }

  @action
  void _goToBoard() {
    NavigationRoutes.navigation(NavigationTypeEnum.pop.value, "");
    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name);
  }

}