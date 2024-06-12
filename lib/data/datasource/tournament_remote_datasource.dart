import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:fc_teams_drawer/session.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentModel>> getTournaments();
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
      "finger_print": fingerPrint,
      "model": deviceInfo.model,
    };

  }

  @override
  Future<List<TournamentModel>> getTournaments() async {

    List<TournamentModel> list = [];

    final deviceInfo = await _getDeviceInfo();

    print("fingerprint => ${deviceInfo["finger_print"]}");
    print("model => ${deviceInfo["model"]}");

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

    print("json remote => $json");

    final deviceInfo = await _getDeviceInfo();
    print("deviceInfo => $deviceInfo");

    await db.collection("tournament")
      .doc(deviceInfo["finger_print"])
      .collection(deviceInfo["model"])
      .doc(json["created_at"])
      .set(json)
      .onError((error, stackTrace) {
        print("error => ${error.toString()}");
        print("stackTrace => ${stackTrace.toString()}");
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(stackTrace.toString());
      })
      .catchError((onError) {
      print("onError => ${onError.toString()}");
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

}