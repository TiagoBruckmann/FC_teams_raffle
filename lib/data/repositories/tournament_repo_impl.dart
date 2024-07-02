import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/app/core/db/collections/tournament.dart';
import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/session.dart';

class TournamentRepoImpl implements TournamentRepo {
  final TournamentRemoteDatasource tournamentRemoteDatasource;
  TournamentRepoImpl( this.tournamentRemoteDatasource );

  @override
  Future<Either<Failure, List<TournamentCollection>>> getTournaments() async {
    try {
      final result = await tournamentRemoteDatasource.getTournaments();
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("get_tournaments_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("get_tournaments_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createTournament( Map<String, dynamic> json ) async {
    try {
      final result = await tournamentRemoteDatasource.createTournament( json );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("create_tournament_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("create_tournament_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updAllKey( GamesCollection game ) async {
    try {
      final result = await tournamentRemoteDatasource.updAllKey( game );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("upd_all_key_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("upd_all_key_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

}