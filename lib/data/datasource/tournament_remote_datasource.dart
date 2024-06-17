import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/key_model.dart';
import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:fc_teams_drawer/session.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentModel>> getTournaments();
  Future<List<KeyModel>> getKeys( Map<String, dynamic> json );
  Future<void> updStatus( Map<String, dynamic> json );
  Future<void> createTournament( Map<String, dynamic> json );

}

class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final FirebaseFirestore db;
  TournamentRemoteDatasourceImpl( this.db );

  Future<Map<String, dynamic>> _getDeviceInfo() async {
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

    return {
      "finger_print": fingerPrint.replaceAll("/", "_").replaceAll(" ", "_"),
      "model": deviceInfo.model.replaceAll(" ", "_"),
    };

  }

  @override
  Future<List<TournamentModel>> getTournaments() async {

    List<TournamentModel> list = [];

    final deviceInfo = await _getDeviceInfo();

    await db.collection("tournament")
      .doc(deviceInfo["finger_print"])
      .collection(deviceInfo["model"])
      .get()
      .then((value) {

        for ( final item in value.docs ) {
          list.add(TournamentModel.fromJson(item.data()));
        }

      })
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(stackTrace.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return list;
  }

  @override
  Future<List<KeyModel>> getKeys( Map<String, dynamic> json ) async {

    List<KeyModel> list = [];

    final deviceInfo = await _getDeviceInfo();

    int qtdGames = json["quantity_games"];
    int game = 0;

    do {
      await db.collection("tournament")
        .doc(deviceInfo["finger_print"])
        .collection(deviceInfo["model"])
        .doc(json["created_at"])
        .collection("keys")
        .doc(json["step"])
        .collection((game + 1).toString())
        .get()
        .then((value) {
          list.add(
            KeyModel.fromJson(value.docs[0].data()),
          );
          game++;
        })
        .onError((error, stackTrace) {
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions(stackTrace.toString());
        })
        .catchError((onError) {
          Session.crash.log(onError);
          throw ServerExceptions(onError.toString());
        });

    } while ( game < qtdGames );

    return list;
  }

  @override
  Future<void> updStatus( Map<String, dynamic> json ) async {

    final deviceInfo = await _getDeviceInfo();

    await db.collection("tournament")
      .doc(deviceInfo["finger_print"])
      .collection(deviceInfo["model"])
      .doc(json["created_at"])
      .update(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(stackTrace.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

  @override
  Future<void> createTournament( Map<String, dynamic> json ) async {

    final deviceInfo = await _getDeviceInfo();

    final tournament = json["tournament"];
    final players = json["players"];
    final keys = json["keys"];

    await db.collection("tournament")
      .doc(deviceInfo["finger_print"])
      .collection(deviceInfo["model"])
      .doc(tournament["created_at"])
      .set(tournament)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(stackTrace.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    await _setPlayers(players);
    await _setKeys(keys);

    return;
  }

  Future<void> _setPlayers( Map<String, dynamic> json ) async {

    final deviceInfo = await _getDeviceInfo();

    final players = json["players"];

    for ( final item in players ) {

      final playerName = item["name"].replaceAll(" ", "_");

      await db.collection("tournament")
        .doc(deviceInfo["finger_print"])
        .collection(deviceInfo["model"])
        .doc(json["created_at"])
        .collection("players")
        .doc(playerName)
        .set(item)
        .onError((error, stackTrace) {
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions(stackTrace.toString());
        })
        .catchError((onError) {
          Session.crash.log(onError);
          throw ServerExceptions(onError.toString());
        });

    }

    return;
  }

  Future<void> _setKeys( Map<String, dynamic> json ) async {

    final deviceInfo = await _getDeviceInfo();
    final keys = json["keys"];

    for ( final item in keys ) {

      await db.collection("tournament")
        .doc(deviceInfo["finger_print"])
        .collection(deviceInfo["model"])
        .doc(json["created_at"])
        .collection("keys")
        .doc(json["step"])
        .collection(item["position"].toString())
        .doc()
        .set(item)
        .onError((error, stackTrace) {
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions(stackTrace.toString());
        })
        .catchError((onError) {
          Session.crash.log(onError);
          throw ServerExceptions(onError.toString());
        });

    }

    return;
  }

}