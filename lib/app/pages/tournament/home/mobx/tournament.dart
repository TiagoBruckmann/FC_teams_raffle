// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';

// import dos pacotes
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fc_teams_drawer/session.dart';
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
  final _tournamentUseCase = TournamentUseCase(getIt());

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
    final successOrFailure = await _tournamentUseCase.getTournaments();

    successOrFailure.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) {
        Session.appEvents.sharedSuccessEvent("get_tournaments", success.toString());
        _addTournamentList(list: success);
        searchStatus(FlutterI18n.translate(_currentContext, "status.active"));
      },
    );

  }

  @action
  void _addTournamentList({ List<TournamentEntity>? list }) {

    if ( tournamentListComplete.isEmpty && list != null && list.isNotEmpty ) {
      tournamentListComplete.addAll(list);
    }

    tournamentList.addAll(List.from(tournamentListComplete));

    _updIsLoading(false);
  }

  @action
  Future<void> searchStatus( String status ) async {

    filterStatus = status;

    await refresh();
    if ( status == TournamentStatusEnum.allPt.name || status == TournamentStatusEnum.allEn.name ) {
      return _updIsLoading(false);
    }

    bool isActiveStatus = true;
    if ( status == TournamentStatusEnum.closedPt.name || status == TournamentStatusEnum.closedEn.name ) {
      isActiveStatus = false;
    }

    tournamentList.retainWhere((element) => element.isActive == isActiveStatus );
    return _updIsLoading(false);

  }

  @action
  Future<void> updStatus( TournamentEntity entity ) async {
    _updIsLoading(true);

    final index = tournamentList.indexWhere((element) => element.isEqual(entity));
    tournamentList.removeAt(index);

    entity = entity.updStatus();
    tournamentList.insert(index, entity);

    await _tournamentUseCase.updateTournament(entity);
    refresh(forceRefresh: true);

  }

  @action
  Future<void> openTournament( TournamentEntity entity ) async {
    if ( entity.id == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.error.get_tournament");
      return;
    }

    await NavigationRoutes.asyncNavigation(RoutesNameEnum.board.name, extra: entity);
    await refresh(forceRefresh: true);
  }

  @action
  Future<void> goToNewTournament() async {
    await NavigationRoutes.asyncNavigation(RoutesNameEnum.newTournament.name);
    await refresh(forceRefresh: true);
  }

  @action
  Future<void> refresh({ bool forceRefresh = false }) async {
    _updIsLoading(true);
    if ( forceRefresh ) {
      return clear();
    }
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