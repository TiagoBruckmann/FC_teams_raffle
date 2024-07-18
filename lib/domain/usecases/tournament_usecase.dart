// import dos domain
import 'package:fc_teams_drawer/app/core/db/collections/tournament.dart';
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

  Future<Either<Failure, void>> createTournament( Map<String, dynamic> json ) async {
    return await tournamentRepo.createTournament( json );
  }

  Future<Either<Failure, void>> updAllKey( GamesCollection game ) async {
    return await tournamentRepo.updAllKey( game );
  }

}