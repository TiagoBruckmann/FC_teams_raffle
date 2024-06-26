import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/key_model.dart';
import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:firebase_performance/firebase_performance.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentModel>> getTournaments();
  Future<void> updStatus( Map<String, dynamic> json );
  Future<void> createTournament( Map<String, dynamic> json );
  Future<void> updWinner( Map<String, dynamic> json );
  Future<void> updSecondPLayer( Map<String, dynamic> json );

}

class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final FirebaseFirestore db;
  TournamentRemoteDatasourceImpl( this.db ) {
    _getDeviceInfo();
  }

  static final Map<String, dynamic> _deviceInfo = {};

  static Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String fingerPrint = "";
    dynamic deviceInfo;
    if ( Platform.isIOS ) {
      deviceInfo = await deviceInfoPlugin.iosInfo;
      fingerPrint = deviceInfo.identifierForVendor;
    } else {
      deviceInfo = await deviceInfoPlugin.androidInfo;
      fingerPrint = deviceInfo.fingerprint;
    }

    _deviceInfo.addAll({
      "finger_print": fingerPrint.replaceAll("/", "_").replaceAll(" ", "_"),
      "model": deviceInfo.model.replaceAll(" ", "_"),
    });

    return;

  }

  @override
  Future<List<TournamentModel>> getTournaments() async {

    List<TournamentModel> list = [];

    if ( _deviceInfo.isEmpty ) {
      await _getDeviceInfo();
    }

    final metric = Session.performance.newHttpMetric("get_tournaments", HttpMethod.Get);
    await metric.start();

    await db.collection("tournaments")
      .doc(_deviceInfo["finger_print"])
      .collection(_deviceInfo["model"])
      .get()
      .then((value) async {

        metric.stop();

        for ( final item in value.docs ) {
          final listKeys = await _getKeys(item.data());
          list.add(TournamentModel.fromJson(item.data(), listKeys));
        }

      })
      .onError((error, stackTrace) {
        metric.stop();
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(stackTrace.toString());
      })
      .catchError((onError) {
        metric.stop();
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return list;
  }

  Future<List<KeyModel>> _getKeys( Map<String, dynamic> json ) async {

    if ( _deviceInfo.isEmpty ) {
      await _getDeviceInfo();
    }

    List<KeyModel> list = [];
    final qtdGames = json["quantity_games"];
    int games = 0;

    do {

      final metric = Session.performance.newHttpMetric("get_keys", HttpMethod.Get);
      await metric.start();

      await db.collection("tournaments")
        .doc(_deviceInfo["finger_print"])
        .collection(_deviceInfo["model"])
        .doc(json["created_at"])
        .collection("keys")
        .doc(json["current_step"])
        .collection(( games + 1 ).toString())
        .get()
        .then((value) async {

          await metric.stop();

          games++;
          if ( value.docs.isNotEmpty ) {
            list.add(
              KeyModel.fromJson(value.docs[0].data()),
            );
          }

          if ( list.length == qtdGames ) {
            return list;
          }

        })
        .onError((error, stackTrace) {
          metric.stop();
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions("serverException: ${stackTrace.toString()}");
        })
        .catchError((onError) {
          metric.stop();
          Session.crash.log(onError);
          throw ServerExceptions("serverException: ${onError.toString()}");
        });

    } while ( games < qtdGames );

    return list;
  }

  @override
  Future<void> updStatus( Map<String, dynamic> json ) async {

    final metric = Session.performance.newHttpMetric("update_status", HttpMethod.Put);
    await metric.start();

    await db.collection("tournaments")
      .doc(_deviceInfo["finger_print"])
      .collection(_deviceInfo["model"])
      .doc(json["created_at"])
      .update(json)
      .onError((error, stackTrace) {
        metric.stop();
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions("serverException: ${stackTrace.toString()}");
      })
      .catchError((onError) {
        metric.stop();
        Session.crash.log(onError);
        throw ServerExceptions("serverException: ${onError.toString()}");
      });

    await metric.stop();

    return;
  }

  @override
  Future<void> createTournament( Map<String, dynamic> json ) async {

    final tournaments = json["tournaments"];
    final players = json["players"];
    final keys = json["keys"];

    final metric = Session.performance.newHttpMetric("create_tournament", HttpMethod.Post);
    await metric.start();

    await db.collection("tournaments")
      .doc(_deviceInfo["finger_print"])
      .collection(_deviceInfo["model"])
      .doc(tournaments["created_at"])
      .set(tournaments)
      .onError((error, stackTrace) {
        metric.stop();
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions("serverException: ${stackTrace.toString()}");
      })
      .catchError((onError) {
        metric.stop();
        Session.crash.log(onError);
        throw ServerExceptions("serverException: ${onError.toString()}");
      });

    await metric.stop();

    await _setPlayers(players);
    await _setKeys(keys);

    return;
  }

  Future<void> _setPlayers( Map<String, dynamic> json ) async {

    final players = json["players"];

    for ( final item in players ) {

      final playerName = item["name"].replaceAll(" ", "_");

      final metric = Session.performance.newHttpMetric("create_players", HttpMethod.Post);
      await metric.start();

      await db.collection("tournaments")
        .doc(_deviceInfo["finger_print"])
        .collection(_deviceInfo["model"])
        .doc(json["created_at"])
        .collection("players")
        .doc(playerName)
        .set(item)
        .onError((error, stackTrace) {
          metric.stop();
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions("serverException: ${stackTrace.toString()}");
        })
        .catchError((onError) {
          metric.stop();
          Session.crash.log(onError);
          throw ServerExceptions("serverException: ${onError.toString()}");
        });

      await metric.stop();

    }

    return;
  }

  Future<void> _setKeys( Map<String, dynamic> json ) async {

    final keys = json["keys"];

    for ( final item in keys ) {

      final metric = Session.performance.newHttpMetric("create_keys", HttpMethod.Post);
      await metric.start();

      await db.collection("tournaments")
        .doc(_deviceInfo["finger_print"])
        .collection(_deviceInfo["model"])
        .doc(json["created_at"])
        .collection("keys")
        .doc(json["step"])
        .collection(item["position"].toString())
        .doc(item["position"].toString())
        .set(item)
        .onError((error, stackTrace) {
          metric.stop();
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions("serverException: ${stackTrace.toString()}");
        })
        .catchError((onError) {
          metric.stop();
          Session.crash.log(onError);
          throw ServerExceptions("serverException: ${onError.toString()}");
        });

      await metric.stop();

    }

    return;
  }

  @override
  Future<void> updWinner( Map<String, dynamic> json ) async {

    final metric = Session.performance.newHttpMetric("update_key", HttpMethod.Put);
    await metric.start();

    await db.collection("tournaments")
      .doc(_deviceInfo["finger_print"])
      .collection(_deviceInfo["model"])
      .doc(json["created_at"])
      .collection("keys")
      .doc(json["step"])
      .collection(json["position"].toString())
      .doc(json["position"].toString())
      .update(json)
      .onError((error, stackTrace) {
        metric.stop();
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions("serverException: ${stackTrace.toString()}");
      })
      .catchError((onError) {
        metric.stop();
        Session.crash.log(onError);
        throw ServerExceptions("serverException: ${onError.toString()}");
      });

    await metric.stop();

    return;
  }

  @override
  Future<void> updSecondPLayer( Map<String, dynamic> json ) async {
    final metric = Session.performance.newHttpMetric("update_second_player", HttpMethod.Put);
    await metric.start();

    await db.collection("tournaments")
      .doc(_deviceInfo["finger_print"])
      .collection(_deviceInfo["model"])
      .doc(json["created_at"])
      .collection("keys")
      .doc(json["step"])
      .collection(json["position"].toString())
      .doc(json["position"].toString())
      .update(json)
      .onError((error, stackTrace) {
        metric.stop();
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions("serverException: ${stackTrace.toString()}");
      })
      .catchError((onError) {
        metric.stop();
        Session.crash.log(onError);
        throw ServerExceptions("serverException: ${onError.toString()}");
      });

    await metric.stop();
    return;
  }

  Future<void> _createNewKey( Map<String, dynamic> json ) async {

    int position = json["position"] + 1;

    final map = {
      "position": position,
      "player1": json["player1"],
      "player2": {},
      "player1_scoreboard": null,
      "player2_scoreboard": null,
      "winner": "",
    };

    final metric = Session.performance.newHttpMetric("create_new_key", HttpMethod.Post);
    await metric.start();

    await db.collection("tournaments")
        .doc(_deviceInfo["finger_print"])
        .collection(_deviceInfo["model"])
        .doc(json["created_at"])
        .collection("keys")
        .doc(json["step"])
        .collection(position.toString())
        .doc(position.toString())
        .set(map)
        .onError((error, stackTrace) {
      metric.stop();
      Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
      throw ServerExceptions("serverException: ${stackTrace.toString()}");
    })
        .catchError((onError) {
      metric.stop();
      Session.crash.log(onError);
      throw ServerExceptions("serverException: ${onError.toString()}");
    });

    await metric.stop();
  }

}