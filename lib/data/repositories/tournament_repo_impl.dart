import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TournamentRepo)
class TournamentRepoImpl implements TournamentRepo {
  final TournamentRemoteDatasource tournamentRemoteDatasource;
  TournamentRepoImpl( this.tournamentRemoteDatasource );

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
  Future<Either<Failure, TournamentEntity?>> getTournamentById( int tournamentId ) async {
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
  Future<Either<Failure, List<PlayerEntity>>> getPlayers() async {
    try {
      final result = await tournamentRemoteDatasource.getPlayers();
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("get_players_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("get_players_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> createPlayers( List<PlayerEntity> players ) async {
    try {
      final result = await tournamentRemoteDatasource.createPlayers( players );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("create_players_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("create_players_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getMatches() async {
    try {
      final result = await tournamentRemoteDatasource.getMatches();
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("get_matches_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("get_matches_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> createMatches( List<MatchEntity> matches ) async {
    try {
      final result = await tournamentRemoteDatasource.createMatches( matches );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("create_matches_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("create_matches_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createTournament( TournamentEntity tournament ) async {
    try {
      final result = await tournamentRemoteDatasource.createTournament( tournament );
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
  Future<Either<Failure, void>> updateTournament( TournamentEntity tournament ) async {
    try {
      final result = await tournamentRemoteDatasource.updateTournament( tournament );
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
  Future<Either<Failure, List<int>>> createTournamentMapper( List<TournamentMapperEntity> mappers ) async {
    try {
      final result = await tournamentRemoteDatasource.createTournamentMapper( mappers );
      return right(result);
    } on ServerExceptions catch ( error ) {
      Session.crash.onError("create_tournament_mapper_server_error", error: error.message);
      return left(ServerFailure(error.message));
    } catch (e) {
      Session.crash.onError("create_tournament_mapper_error", error: e);
      return left(GeneralFailure(e.toString()));
    }
  }

}