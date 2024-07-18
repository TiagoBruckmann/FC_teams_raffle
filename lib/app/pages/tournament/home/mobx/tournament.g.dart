// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TournamentMobx on _TournamentMobx, Store {
  late final _$filterStatusAtom =
      Atom(name: '_TournamentMobx.filterStatus', context: context);

  @override
  String get filterStatus {
    _$filterStatusAtom.reportRead();
    return super.filterStatus;
  }

  @override
  set filterStatus(String value) {
    _$filterStatusAtom.reportWrite(value, super.filterStatus, () {
      super.filterStatus = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_TournamentMobx.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getTournamentsAsyncAction =
      AsyncAction('_TournamentMobx.getTournaments', context: context);

  @override
  Future<void> getTournaments() {
    return _$getTournamentsAsyncAction.run(() => super.getTournaments());
  }

  late final _$searchStatusAsyncAction =
      AsyncAction('_TournamentMobx.searchStatus', context: context);

  @override
  Future<void> searchStatus(String status) {
    return _$searchStatusAsyncAction.run(() => super.searchStatus(status));
  }

  late final _$updStatusAsyncAction =
      AsyncAction('_TournamentMobx.updStatus', context: context);

  @override
  Future<void> updStatus(TournamentCollection entity) {
    return _$updStatusAsyncAction.run(() => super.updStatus(entity));
  }

  late final _$refreshAsyncAction =
      AsyncAction('_TournamentMobx.refresh', context: context);

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  late final _$_TournamentMobxActionController =
      ActionController(name: '_TournamentMobx', context: context);

  @override
  void _updIsLoading(bool value) {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx._updIsLoading');
    try {
      return super._updIsLoading(value);
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setItemsMenu() {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx._setItemsMenu');
    try {
      return super._setItemsMenu();
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _addTournamentList({List<TournamentCollection>? list}) {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx._addTournamentList');
    try {
      return super._addTournamentList(list: list);
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openTournament(TournamentCollection entity) {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx.openTournament');
    try {
      return super.openTournament(entity);
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToNewTournament() {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx.goToNewTournament');
    try {
      return super.goToNewTournament();
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx.clear');
    try {
      return super.clear();
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_TournamentMobxActionController.startAction(
        name: '_TournamentMobx.dispose');
    try {
      return super.dispose();
    } finally {
      _$_TournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filterStatus: ${filterStatus},
isLoading: ${isLoading}
    ''';
  }
}
