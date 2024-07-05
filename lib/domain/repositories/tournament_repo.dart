import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/app/core/db/collections/game.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

abstract class TournamentRepo {

  Future<Either<Failure, List<TournamentCollection>>> getTournaments();
  Future<Either<Failure, void>> createTournament( TournamentCollection tournament );

}