import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class TeamRemoteDatasource {

  Future<void> getDataSync();

}

class TeamRemoteDatasourceImpl implements TeamRemoteDatasource {
  final FirebaseDatabase db;
  TeamRemoteDatasourceImpl( this.db );

  @override
  Future<void> getDataSync() async {

    final teamsRef = db.ref("data");
    db.setLoggingEnabled(true);
    db.setPersistenceEnabled(true);
    db.setPersistenceCacheSizeBytes(10000000);

    try {

      final response = await teamsRef.get();
      _syncData(response.value);

    } catch ( error ) {
      Session.crash.onError("get_data_sync_firebase", error: error);
      throw ServerExceptions("get_data_sync_firebase => $error");
    }

    return;
  }

  Future<void> _syncData( dynamic json ) async {

    try {

      final versionDataSync = int.parse(await Session.secureStorage.readStorage("version_data_sync") ?? "0");

      final localDb = await LocalDb().getFCTeamCollection(versionDataSync);

      final fcTeamCollection = FCTeamsCollection.fromJson(json);

      int localVersion = localDb?.versionDataSync ?? versionDataSync;

      if ( localVersion < fcTeamCollection.versionDataSync! ) {

        final isSuccessSyncDataModel = await LocalDb().syncFCTeamDataModel(fcTeamCollection);

        if ( !isSuccessSyncDataModel ) {
          Session.crash.onError("Failure on Sync FC Teams data model");
          throw CacheExceptions("Failure on Sync FC Teams data model");
        }

        Session.fcTeamCollection = FCTeamsCollection.collectionToEntity(fcTeamCollection);

      } else {
        Session.fcTeamCollection = FCTeamsCollection.collectionToEntity(localDb!);
      }

      return;

    } catch ( error ) {
      Session.crash.onError("get_data_sync_local_db", error: error);
      throw CacheExceptions("get_data_sync_local_db => $error");
    }

  }

}