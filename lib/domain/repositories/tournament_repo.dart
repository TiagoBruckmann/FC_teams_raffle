import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

abstract class TournamentRepo {

  Future<Either<Failure, List<TournamentEntity>>> getTournaments();
  Future<Either<Failure, void>> updStatus( Map<String, dynamic> json );
  Future<Either<Failure, void>> createTournament( Map<String, dynamic> json );
  Future<Either<Failure, void>> updWinner( Map<String, dynamic> json );
  Future<Either<Failure, void>> updSecondPLayer( Map<String, dynamic> json );

}