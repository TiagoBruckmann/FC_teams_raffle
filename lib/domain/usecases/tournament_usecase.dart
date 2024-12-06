// import dos domain
import 'package:fc_teams_drawer/app/core/db/collections/game.dart';
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

// import dos pacotes
import 'package:dartz/dartz.dart';

class TournamentUseCase {
  final TournamentRepo tournamentRepo;
  TournamentUseCase( this.tournamentRepo );

  Future<Either<Failure, List<TournamentCollection>>> getTournaments() async {
    return await tournamentRepo.getTournaments();
  }

  Future<Either<Failure, void>> createTournament( TournamentCollection tournament ) async {
    return await tournamentRepo.createTournament( tournament );
  }

}