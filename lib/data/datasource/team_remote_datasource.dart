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
  TeamRemoteDatasourceImpl( this._service );

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

      final json = response.value as dynamic;

      for ( final team in json["teams"] ) {
        if ( team != null ) {
          Session.teams.add(TeamModel.fromJson(team));
        }
      }

      return;

    } catch ( error ) {
      Session.crash.onError("get_data_sync_firebase", error: error);
      throw ServerExceptions("get_data_sync_firebase => $error");
    }
  }

}