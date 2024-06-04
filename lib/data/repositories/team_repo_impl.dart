import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/data/datasource/team_remote_datasource.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';
import 'package:fc_teams_drawer/domain/repositories/team_repo.dart';
import 'package:fc_teams_drawer/session.dart';

class TeamRepoImpl implements TeamRepo {
  final TeamRemoteDatasource remoteDatasource;
  TeamRepoImpl( this.remoteDatasource );

  @override
  Future<Either<Failure, void>> getDataSync() async {
    try {
      final result = await remoteDatasource.getDataSync();
      return right(result);
    } on ServerExceptions {
      return left(ServerFailure());
    } catch (e) {
      Session.crash.onError("get_data_sync_error", error: e);
      return left(GeneralFailure());
    }
  }

}