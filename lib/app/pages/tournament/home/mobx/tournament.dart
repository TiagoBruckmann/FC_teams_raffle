// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';

// import dos pacotes
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mobx/mobx.dart';

part 'tournament.g.dart';

enum TournamentStatusEnum {
  allPt("Todos"),
  activePt("Ativos"),
  closedPt("Finalizados"),
  allEn("All"),
  activeEn("Active"),
  closedEn("Closed");

  final String name;
  const TournamentStatusEnum( this.name );
}

class TournamentMobx extends _TournamentMobx with _$TournamentMobx {}

abstract class _TournamentMobx with Store {

  final _currentContext = Session.globalContext.currentContext!;
  final _useCase = TournamentUseCase(getIt());

  ObservableList<TournamentEntity> tournamentListComplete = ObservableList();
  ObservableList<TournamentEntity> tournamentList = ObservableList();

  ObservableList<String> itemsMenu = ObservableList();

  @observable
  String filterStatus = "";

  @observable
  bool isLoading = true;

  @action
  void _updIsLoading( bool value ) => isLoading = value;

  @action
  void _setItemsMenu() {

    filterStatus = FlutterI18n.translate(_currentContext, "status.all");

    itemsMenu.addAll([
      FlutterI18n.translate(_currentContext, "status.all"),
      FlutterI18n.translate(_currentContext, "status.active"),
      FlutterI18n.translate(_currentContext, "status.closed"),
    ]);

    return;
  }

  @action
  Future<void> getTournaments() async {

    _setItemsMenu();
    final successOrFailure = await _useCase.getTournaments();

    successOrFailure.fold(
      (failure) => SharedServices.logError("failure_get_tournaments", message: failure.message),
      (success) {
        Session.appEvents.sharedSuccessEvent("get_tournaments", success.toString());
        _addTournamentList(list: success);
      },
    );

  }

  @action
  void _addTournamentList({ List<TournamentEntity>? list }) {

    if ( tournamentListComplete.isEmpty && list != null && list.isNotEmpty ) {
      tournamentListComplete.addAll(list);
    }

    tournamentList.addAll(tournamentListComplete);
    _updIsLoading(false);
  }

  @action
  Future<void> searchStatus( String status ) async {

    filterStatus = status;

    await refresh();
    if ( status == TournamentStatusEnum.allPt.name || status == TournamentStatusEnum.allEn.name ) {
      return _updIsLoading(false);
    }

    bool filter = true;
    if ( status == TournamentStatusEnum.closedPt.name || status == TournamentStatusEnum.closedEn.name ) {
      filter = false;
    }

    tournamentList.retainWhere((element) => element.isActive == filter );
    return _updIsLoading(false);

  }

  @action
  Future<void> updStatus( TournamentEntity entity ) async {
    _updIsLoading(true);

    final response = await _useCase.updStatus(entity.updStatus( !entity.isActive ));

    response.fold(
      (failure) {
        SharedServices.logError("failure_upd_status_tournament", message: failure.message);
        _updIsLoading(false);
      },
      (success) => clear(),
    );
  }

  @action
  void openTournament( TournamentEntity entity ) => Navigator.pushNamed(_currentContext, "/board", arguments: entity.toMap());

  @action
  void goToNewTournament() => NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.newTournament.name);

  @action
  Future<void> refresh() async {
    _updIsLoading(true);
    tournamentList.clear();
    _addTournamentList();
  }

  @action
  void clear() {
    tournamentList.clear();
    tournamentListComplete.clear();
    itemsMenu.clear();
    getTournaments();
  }

  @action
  void dispose() {
    tournamentList.clear();
    tournamentListComplete.clear();
  }

}