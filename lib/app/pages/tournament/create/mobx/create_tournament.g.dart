// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tournament.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTournamentMobx on _CreateTournamentMobx, Store {
  late final _$isLoadingAtom =
      Atom(name: '_CreateTournamentMobx.isLoading', context: context);

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

  late final _$qtdPlayersAtom =
      Atom(name: '_CreateTournamentMobx.qtdPlayers', context: context);

  @override
  int get qtdPlayers {
    _$qtdPlayersAtom.reportRead();
    return super.qtdPlayers;
  }

  @override
  set qtdPlayers(int value) {
    _$qtdPlayersAtom.reportWrite(value, super.qtdPlayers, () {
      super.qtdPlayers = value;
    });
  }

  late final _$qtdDefeatsAtom =
      Atom(name: '_CreateTournamentMobx.qtdDefeats', context: context);

  @override
  int get qtdDefeats {
    _$qtdDefeatsAtom.reportRead();
    return super.qtdDefeats;
  }

  @override
  set qtdDefeats(int value) {
    _$qtdDefeatsAtom.reportWrite(value, super.qtdDefeats, () {
      super.qtdDefeats = value;
    });
  }

  late final _$raffleTeamsAtom =
      Atom(name: '_CreateTournamentMobx.raffleTeams', context: context);

  @override
  bool get raffleTeams {
    _$raffleTeamsAtom.reportRead();
    return super.raffleTeams;
  }

  @override
  set raffleTeams(bool value) {
    _$raffleTeamsAtom.reportWrite(value, super.raffleTeams, () {
      super.raffleTeams = value;
    });
  }

  late final _$_saveTournamentAsyncAction =
      AsyncAction('_CreateTournamentMobx._saveTournament', context: context);

  @override
  Future<void> _saveTournament() {
    return _$_saveTournamentAsyncAction.run(() => super._saveTournament());
  }

  late final _$_createTournamentMapperAsyncAction = AsyncAction(
      '_CreateTournamentMobx._createTournamentMapper',
      context: context);

  @override
  Future<void> _createTournamentMapper(TournamentEntity tournament) {
    return _$_createTournamentMapperAsyncAction
        .run(() => super._createTournamentMapper(tournament));
  }

  late final _$_getPlayersAsyncAction =
      AsyncAction('_CreateTournamentMobx._getPlayers', context: context);

  @override
  Future<List<int>> _getPlayers() {
    return _$_getPlayersAsyncAction.run(() => super._getPlayers());
  }

  late final _$_sortTeamsAsyncAction =
      AsyncAction('_CreateTournamentMobx._sortTeams', context: context);

  @override
  Future<String> _sortTeams(List<String> listTeams) {
    return _$_sortTeamsAsyncAction.run(() => super._sortTeams(listTeams));
  }

  late final _$_getMatchesAsyncAction =
      AsyncAction('_CreateTournamentMobx._getMatches', context: context);

  @override
  Future<List<int>> _getMatches() {
    return _$_getMatchesAsyncAction.run(() => super._getMatches());
  }

  late final _$_CreateTournamentMobxActionController =
      ActionController(name: '_CreateTournamentMobx', context: context);

  @override
  void initialSettings() {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx.initialSettings');
    try {
      return super.initialSettings();
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updIsLoading(bool value) {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx.updIsLoading');
    try {
      return super.updIsLoading(value);
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQtdPlayers(int value) {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx.setQtdPlayers');
    try {
      return super.setQtdPlayers(value);
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQtdDefeats(int value) {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx.setQtdDefeats');
    try {
      return super.setQtdDefeats(value);
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updRaffleTeams() {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx.updRaffleTeams');
    try {
      return super.updRaffleTeams();
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFields() {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx.validateFields');
    try {
      return super.validateFields();
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _goToBoard(TournamentEntity tournament) {
    final _$actionInfo = _$_CreateTournamentMobxActionController.startAction(
        name: '_CreateTournamentMobx._goToBoard');
    try {
      return super._goToBoard(tournament);
    } finally {
      _$_CreateTournamentMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
qtdPlayers: ${qtdPlayers},
qtdDefeats: ${qtdDefeats},
raffleTeams: ${raffleTeams}
    ''';
  }
}
