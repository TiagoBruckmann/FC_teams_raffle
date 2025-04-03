import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:injectable/injectable.dart';

abstract class TournamentRepo {

  Future<Either<Failure, void>> createTournament( Map<String, dynamic> json );
  Future<Either<Failure, void>> updateTournament( Map<String, dynamic> json );
  Future<Either<Failure, List<TournamentEntity>>> getTournaments();
  Future<Either<Failure, TournamentEntity?>> getTournamentById( String tournamentId );
  Future<Either<Failure, void>> createOrUpdatePlayers( Map<String, dynamic> json);
  Future<Either<Failure, void>> createOrUpdateMatches( Map<String, dynamic> json );

}

@Injectable(as: TournamentRepo)
class TournamentRepoImpl implements TournamentRepo {
  final TournamentRemoteDatasource tournamentRemoteDatasource;
  TournamentRepoImpl( this.tournamentRemoteDatasource );

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
  Future<Either<Failure, void>> updateTournament( Map<String, dynamic> json ) async {
    try {
      final result = await tournamentRemoteDatasource.updateTournament( json );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("update_tournament_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("update_tournament_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TournamentEntity>>> getTournaments() async {
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
  Future<Either<Failure, TournamentEntity?>> getTournamentById( String tournamentId ) async {
    try {
      final result = await tournamentRemoteDatasource.getTournamentById( tournamentId );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("get_tournament_by_id_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("get_tournament_by_id_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createOrUpdatePlayers( Map<String, dynamic> json ) async {
    try {
      final result = await tournamentRemoteDatasource.createOrUpdatePlayers( json );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("create_or_update_player_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("create_player_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createOrUpdateMatches( Map<String, dynamic> json ) async {
    try {
      final result = await tournamentRemoteDatasource.createOrUpdateMatches( json );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("create_or_update_matches_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("create_matches_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

}