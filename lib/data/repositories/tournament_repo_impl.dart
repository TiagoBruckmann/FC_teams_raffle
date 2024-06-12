import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/session.dart';

class TournamentRepoImpl implements TournamentRepo {
  final TournamentRemoteDatasource tournamentRemoteDatasource;
  TournamentRepoImpl( this.tournamentRemoteDatasource );

  @override
  Future<Either<Failure, List<TournamentEntity>>> getTournaments() async {
    try {
      final result = await tournamentRemoteDatasource.getTournaments();
      return right(result);
    } on ServerExceptions {
      return left(ServerFailure());
    } catch (e) {
      Session.crash.onError("get_tournaments_error", error: e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updStatus( Map<String, dynamic> json ) async {
    try {
      final result = await tournamentRemoteDatasource.updStatus( json );
      return right(result);
    } on ServerExceptions {
      return left(ServerFailure());
    } catch (e) {
      Session.crash.onError("upd_status_error", error: e);
      return left(GeneralFailure());
    }
  }

}