import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/utils/firebase_service.dart';
import 'package:fc_teams_drawer/domain/entity/fc_teams_drawer.dart';
import 'package:fc_teams_drawer/domain/entity/team.dart';
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
    _service.db.setPersistenceEnabled(true);
    _service.db.setPersistenceCacheSizeBytes(10000000);

    try {

      final metric = await Session.performance.newHttpMetric("get_teams", HttpMethod.Get);
      await metric.start();

      final response = await teamsRef.get();

      await metric.stop();

      return await _syncData(response.value);

    } catch ( error ) {
      Session.crash.onError("get_data_sync_firebase", error: error);
      throw ServerExceptions("get_data_sync_firebase => $error");
    }
  }

  Future<void> _syncData( dynamic json ) async {

    try {

      final fcTeamCollection = FcTeamsDrawerEntity.fromJson(json);

      int localVersion = await _localDb.fcTeamDrawerDao.getLastVersionDB() ?? 0;

      if ( localVersion < fcTeamCollection.versionDataSync ) {

        final List<TeamEntity> teams = [];
        for ( final team in json["teams"] ) {
          teams.add(TeamEntity.fromJson(team));
        }

        await _localDb.teamDao.insertAllTeams(teams);
        Session.teams.clear();
        Session.teams.addAll(teams.toSet().toList());

        return;

      }

      final teams = await _localDb.teamDao.getAllTeams();
      Session.teams.clear();
      Session.teams.addAll(teams.toSet().toList());

      return;

    } catch ( error ) {
      Session.teams.clear();
      Session.crash.onError("get_data_sync_local_service.db", error: error);
      throw CacheExceptions("get_data_sync_local_service.db => $error");
    }

  }

}