// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashMobx on _SplashMobx, Store {
  late final _$_getDataSyncAsyncAction =
      AsyncAction('_SplashMobx._getDataSync', context: context);

  @override
  Future<void> _getDataSync() {
    return _$_getDataSyncAsyncAction.run(() => super._getDataSync());
  }

  late final _$_SplashMobxActionController =
      ActionController(name: '_SplashMobx', context: context);

  @override
  void startTimer() {
    final _$actionInfo = _$_SplashMobxActionController.startAction(
        name: '_SplashMobx.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_SplashMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _goToHome() {
    final _$actionInfo = _$_SplashMobxActionController.startAction(
        name: '_SplashMobx._goToHome');
    try {
      return super._goToHome();
    } finally {
      _$_SplashMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
