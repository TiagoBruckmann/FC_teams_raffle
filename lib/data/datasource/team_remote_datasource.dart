import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/team_model.dart';
import 'package:fc_teams_drawer/data/utils/firebase_service.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:injectable/injectable.dart';

abstract class TeamRemoteDatasource {

  Future<void> getDataSync();

}

@Injectable(as: TeamRemoteDatasource)
class TeamRemoteDatasourceImpl implements TeamRemoteDatasource {
  final FirebaseService _service;
  final LocalDb _localDb;
  TeamRemoteDatasourceImpl( this._service, this._localDb );

  @override
  Future<void> getDataSync() async {

    final teamsRef = _service.db.ref("data");
    _service.db.setLoggingEnabled(true);
    _service.db.setPersistenceCacheSizeBytes(10000000);

    try {

      final metric = await Session.performance.newHttpMetric("get_teams", HttpMethod.Get);
      await metric.start();

      final response = await teamsRef.get();

      await metric.stop();

      return await _syncData(response.value);

    } catch ( error ) {
      final versionDataSync = int.parse(await Session.secureStorage.readStorage("version_data_sync") ?? "0");
      final fcCollection = await _localDb.getFCTeamCollection(versionDataSync);

      if ( fcCollection != null ) {
        _setGlobalList(fcCollection);
      }

      Session.crash.onError("get_data_sync_firebase", error: error);
      throw ServerExceptions("get_data_sync_firebase => $error");
    }
  }

  Future<void> _syncData( dynamic json ) async {

    try {

      final versionDataSync = int.parse(await Session.secureStorage.readStorage("version_data_sync") ?? "0");

      final localDb = await _localDb.getFCTeamCollection(versionDataSync);

      final fcTeamCollection = FCTeamsCollection.fromJson(json);

      int localVersion = localDb?.versionDataSync ?? versionDataSync;

      if ( localVersion < fcTeamCollection.versionDataSync! ) {

        final isSuccessSyncDataModel = await LocalDb().syncFCTeamDataModel(fcTeamCollection);

        if ( !isSuccessSyncDataModel ) {
          Session.crash.onError("Failure on Sync FC Teams data model");
          throw CacheExceptions("Failure on Sync FC Teams data model");
        }

        final fcCollection = FCTeamsCollection.collectionToEntity(fcTeamCollection);

        _setGlobalList(fcCollection);

        return;

      }

      final fcCollection = FCTeamsCollection.collectionToEntity(localDb!);
      _setGlobalList(fcCollection);

      return;

    } catch ( error ) {
      final List<TeamModel> teams = [];
      for ( final team in json["teams"] ) {
        if ( team != null ) {
          teams.add(TeamModel.fromJson(team));
        }
      }

      Session.teams.clear();
      Session.teams.addAll(teams);

      Session.crash.onError("get_data_sync_local_service.db", error: error);
      throw CacheExceptions("get_data_sync_local_service.db => $error");
    }

  }

  void _setGlobalList( FCTeamsCollection collection ) {
    final List<TeamModel> list = [];

    if ( collection.teamCollection != null && collection.teamCollection!.isNotEmpty ) {

      for ( final team in collection.teamCollection! ) {
        if ( team.isNotNull() ) {
          list.add(
            TeamModel.fromFcCollection(team),
          );
        }
      }

    }
  }

}