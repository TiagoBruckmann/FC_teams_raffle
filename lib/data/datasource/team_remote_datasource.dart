import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/session.dart';

abstract class TeamRemoteDatasource {

  Future<void> getDataSync();

}

class TeamRemoteDatasourceImpl implements TeamRemoteDatasource {
  final FirebaseFirestore db;
  TeamRemoteDatasourceImpl( this.db );

  @override
  Future<void> getDataSync() async {
    await db.collection("teams")
    .get()
    .then((value) => _syncData(value.docs))
    .onError((error, stackTrace) {
      Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
      throw ServerExceptions();
    })
    .catchError((onError) {
      Session.crash.log(onError);
      throw ServerExceptions();
    });

    return;
  }

  Future<void> _syncData( dynamic json ) async {

    final versionDataSync = await Session.secureStorage.readStorage("version_data_sync") ?? "0";

    final localDb = await LocalDb().getFCTeamCollection(versionDataSync);

    final fcTeamCollection = FCTeamsCollection.fromJson(json);

    if ( localDb?.versionDataSync != fcTeamCollection.versionDataSync ) {

      final isSuccessSyncDataModel = await LocalDb().syncFCTeamDataModel(fcTeamCollection);

      if ( !isSuccessSyncDataModel ) {
        throw CacheExceptions("Failure on Sync FC Teams data model");
      }

      Session.fcTeamCollection = FCTeamsCollection.collectionToEntity(fcTeamCollection);

    } else {
      Session.fcTeamCollection = FCTeamsCollection.collectionToEntity(localDb!);
    }

    return;
  }

}