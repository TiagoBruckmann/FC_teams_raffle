// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeMobx on _HomeMobx, Store {
  late final _$verifyVersionAsyncAction =
      AsyncAction('_HomeMobx.verifyVersion', context: context);

  @override
  Future<void> verifyVersion() {
    return _$verifyVersionAsyncAction.run(() => super.verifyVersion());
  }

  late final _$_HomeMobxActionController =
      ActionController(name: '_HomeMobx', context: context);

  @override
  void goToResponse({bool isSolo = true}) {
    final _$actionInfo =
        _$_HomeMobxActionController.startAction(name: '_HomeMobx.goToResponse');
    try {
      return super.goToResponse(isSolo: isSolo);
    } finally {
      _$_HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToTournament() {
    final _$actionInfo = _$_HomeMobxActionController.startAction(
        name: '_HomeMobx.goToTournament');
    try {
      return super.goToTournament();
    } finally {
      _$_HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
