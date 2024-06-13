// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BoardMobx on _BoardMobx, Store {
  late final _$getKeysAsyncAction =
      AsyncAction('_BoardMobx.getKeys', context: context);

  @override
  Future<void> getKeys(Map<String, dynamic> params) {
    return _$getKeysAsyncAction.run(() => super.getKeys(params));
  }

  late final _$_BoardMobxActionController =
      ActionController(name: '_BoardMobx', context: context);

  @override
  void selectOctaves() {
    final _$actionInfo = _$_BoardMobxActionController.startAction(
        name: '_BoardMobx.selectOctaves');
    try {
      return super.selectOctaves();
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectQuarter() {
    final _$actionInfo = _$_BoardMobxActionController.startAction(
        name: '_BoardMobx.selectQuarter');
    try {
      return super.selectQuarter();
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectSemi() {
    final _$actionInfo =
        _$_BoardMobxActionController.startAction(name: '_BoardMobx.selectSemi');
    try {
      return super.selectSemi();
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectFinal() {
    final _$actionInfo = _$_BoardMobxActionController.startAction(
        name: '_BoardMobx.selectFinal');
    try {
      return super.selectFinal();
    } finally {
      _$_BoardMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
