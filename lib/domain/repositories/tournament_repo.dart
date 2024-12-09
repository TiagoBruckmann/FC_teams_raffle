import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

abstract class TournamentRepo {

  Future<Either<Failure, List<TournamentEntity>>> getTournaments();
  Future<Either<Failure, List<PlayerEntity>>> getPlayers();
  Future<Either<Failure, List<int>>> createPlayers( List<PlayerEntity> players );
  Future<Either<Failure, List<MatchEntity>>> getMatches();
  Future<Either<Failure, List<int>>> createMatches( List<MatchEntity> matches );
  Future<Either<Failure, void>> createTournament( TournamentEntity tournament );
  Future<Either<Failure, void>> updateTournament( TournamentEntity tournament );

}