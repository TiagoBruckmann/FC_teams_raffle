// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectionMobx on _ConnectionMobx, Store {
  late final _$connectionStatusAtom =
      Atom(name: '_ConnectionMobx.connectionStatus', context: context);

  @override
  ConnectivityResult get connectionStatus {
    _$connectionStatusAtom.reportRead();
    return super.connectionStatus;
  }

  @override
  set connectionStatus(ConnectivityResult value) {
    _$connectionStatusAtom.reportWrite(value, super.connectionStatus, () {
      super.connectionStatus = value;
    });
  }

  late final _$_connectivityAtom =
      Atom(name: '_ConnectionMobx._connectivity', context: context);

  @override
  Connectivity get _connectivity {
    _$_connectivityAtom.reportRead();
    return super._connectivity;
  }

  @override
  set _connectivity(Connectivity value) {
    _$_connectivityAtom.reportWrite(value, super._connectivity, () {
      super._connectivity = value;
    });
  }

  late final _$_subscriptionAtom =
      Atom(name: '_ConnectionMobx._subscription', context: context);

  @override
  StreamSubscription<List<ConnectivityResult>>? get _subscription {
    _$_subscriptionAtom.reportRead();
    return super._subscription;
  }

  @override
  set _subscription(StreamSubscription<List<ConnectivityResult>>? value) {
    _$_subscriptionAtom.reportWrite(value, super._subscription, () {
      super._subscription = value;
    });
  }

  late final _$verifyConnectionAsyncAction =
      AsyncAction('_ConnectionMobx.verifyConnection', context: context);

  @override
  Future<void> verifyConnection() {
    return _$verifyConnectionAsyncAction.run(() => super.verifyConnection());
  }

  late final _$updateConnectionStatusAsyncAction =
      AsyncAction('_ConnectionMobx.updateConnectionStatus', context: context);

  @override
  Future<void> updateConnectionStatus(ConnectivityResult result) {
    return _$updateConnectionStatusAsyncAction
        .run(() => super.updateConnectionStatus(result));
  }

  late final _$_ConnectionMobxActionController =
      ActionController(name: '_ConnectionMobx', context: context);

  @override
  void listenChangeConnectivityState() {
    final _$actionInfo = _$_ConnectionMobxActionController.startAction(
        name: '_ConnectionMobx.listenChangeConnectivityState');
    try {
      return super.listenChangeConnectivityState();
    } finally {
      _$_ConnectionMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancelListen() {
    final _$actionInfo = _$_ConnectionMobxActionController.startAction(
        name: '_ConnectionMobx.cancelListen');
    try {
      return super.cancelListen();
    } finally {
      _$_ConnectionMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
connectionStatus: ${connectionStatus}
    ''';
  }
}
