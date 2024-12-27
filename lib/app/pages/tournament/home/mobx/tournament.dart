// import das telas
import 'package:fc_teams_drawer/app/core/routes/navigation_routes.dart';
import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';

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
        searchStatus("Ativos");
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
    clear();

  }

  @action
  void openTournament( TournamentEntity entity ) {
    if ( entity.id == null ) {
      CustomSnackBar(messageKey: "pages.tournament.board.error.get_tournament");
      return;
    }

    final List<TournamentMapperEntity> list = [TournamentMapperEntity(entity.id!, id: entity.id!)];

    tournamentListComplete.where((tournament) {
      bool isSuccess = false;
      if ( tournament.id != null && entity.id! == tournament.id ) {

        print("tournament.getPlayers => ${tournament.getPlayers}");
        print("tournament.getMatches => ${tournament.getMatches}");

        for ( final player in tournament.getPlayers ) {
          if ( player.id != null ) {
            list.add(TournamentMapperEntity(entity.id!, playerId: player.id!));
          }
        }

        for ( final match in tournament.getMatches ) {
          if ( match.id != null ) {
            list.add(TournamentMapperEntity(entity.id!, matchId: match.id!));
          }
        }

      }

      return isSuccess;
    });
    print("list => $list");

    return NavigationRoutes.navigation(NavigationTypeEnum.push.value, RoutesNameEnum.board.name, extra: list);
  }

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