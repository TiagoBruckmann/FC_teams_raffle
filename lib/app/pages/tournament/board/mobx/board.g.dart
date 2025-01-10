// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BoardMobx on _BoardMobx, Store {
  late final _$isLoadingAtom =
      Atom(name: '_BoardMobx.isLoading', context: context);

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

  late final _$_tournamentAtom =
      Atom(name: '_BoardMobx._tournament', context: context);

  @override
  TournamentEntity get _tournament {
    _$_tournamentAtom.reportRead();
    return super._tournament;
  }

  bool __tournamentIsInitialized = false;

  @override
  set _tournament(TournamentEntity value) {
    _$_tournamentAtom.reportWrite(
        value, __tournamentIsInitialized ? super._tournament : null, () {
      super._tournament = value;
      __tournamentIsInitialized = true;
    });
  }

  late final _$selectedStepAtom =
      Atom(name: '_BoardMobx.selectedStep', context: context);

  @override
  int get selectedStep {
    _$selectedStepAtom.reportRead();
    return super.selectedStep;
  }

  @override
  set selectedStep(int value) {
    _$selectedStepAtom.reportWrite(value, super.selectedStep, () {
      super.selectedStep = value;
    });
  }

  late final _$qtdStepsAtom =
      Atom(name: '_BoardMobx.qtdSteps', context: context);

  @override
  int get qtdSteps {
    _$qtdStepsAtom.reportRead();
    return super.qtdSteps;
  }

  @override
  set qtdSteps(int value) {
    _$qtdStepsAtom.reportWrite(value, super.qtdSteps, () {
      super.qtdSteps = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_BoardMobx.init', context: context);

  @override
  Future<void> init(TournamentEntity tournament) {
    return _$initAsyncAction.run(() => super.init(tournament));
  }

  late final _$_getTournamentAsyncAction =
      AsyncAction('_BoardMobx._getTournament', context: context);

  @override
  Future<TournamentEntity?> _getTournament(int tournamentId) {
    return _$_getTournamentAsyncAction
        .run(() => super._getTournament(tournamentId));
  }

  late final _$setGoalsAsyncAction =
      AsyncAction('_BoardMobx.setGoals', context: context);

  @override
  Future<void> setGoals(MatchEntity match, {int? score1, int? score2}) {
    return _$setGoalsAsyncAction
        .run(() => super.setGoals(match, score1: score1, score2: score2));
  }

  late final _$_updNextWinnerGameAsyncAction =
      AsyncAction('_BoardMobx._updNextWinnerGame', context: context);

  @override
  Future<void> _updNextWinnerGame(MatchEntity match) {
    return _$_updNextWinnerGameAsyncAction
        .run(() => super._updNextWinnerGame(match));
  }

  late final _$_updNextLoserGameAsyncAction =
      AsyncAction('_BoardMobx._updNextLoserGame', context: context);

  @override
  Future<void> _updNextLoserGame(MatchEntity match) {
    return _$_updNextLoserGameAsyncAction
        .run(() => super._updNextLoserGame(match));
  }

  late final _$_updateTournamentAsyncAction =
      AsyncAction('_BoardMobx._updateTournament', context: context);

  @override
  Future<void> _updateTournament(List<int> matchesIds) {
    return _$_updateTournamentAsyncAction
        .run(() => super._updateTournament(matchesIds));
  }

  late final _$_BoardMobxActionController =
      ActionController(name: '_BoardMobx', context: context);

  @override
  void updIsLoading(bool value) {
    final _$actionInfo = _$_BoardMobxActionController.startAction(
        name: '_BoardMobx.updIsLoading');
    try {
      return super.updIsLoading(value);
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectStep(int step) {
    final _$actionInfo =
        _$_BoardMobxActionController.startAction(name: '_BoardMobx.selectStep');
    try {
      return super.selectStep(step);
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setSteps() {
    final _$actionInfo =
        _$_BoardMobxActionController.startAction(name: '_BoardMobx._setSteps');
    try {
      return super._setSteps();
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
selectedStep: ${selectedStep},
qtdSteps: ${qtdSteps}
    ''';
  }
}
