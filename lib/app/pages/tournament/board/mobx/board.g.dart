// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BoardMobx on _BoardMobx, Store {
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

  late final _$getKeysAsyncAction =
      AsyncAction('_BoardMobx.getKeys', context: context);

  @override
  Future<void> getKeys(Map<String, dynamic> params) {
    return _$getKeysAsyncAction.run(() => super.getKeys(params));
  }

  late final _$_BoardMobxActionController =
      ActionController(name: '_BoardMobx', context: context);

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
  void _setSteps(String stepName) {
    final _$actionInfo =
        _$_BoardMobxActionController.startAction(name: '_BoardMobx._setSteps');
    try {
      return super._setSteps(stepName);
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setListKeys(List<KeyEntity> list) {
    final _$actionInfo = _$_BoardMobxActionController.startAction(
        name: '_BoardMobx._setListKeys');
    try {
      return super._setListKeys(list);
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGoals(KeyEntity entity, {int? player1, int? player2}) {
    final _$actionInfo =
        _$_BoardMobxActionController.startAction(name: '_BoardMobx.setGoals');
    try {
      return super.setGoals(entity, player1: player1, player2: player2);
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
qtdSteps: ${qtdSteps}
    ''';
  }
}
