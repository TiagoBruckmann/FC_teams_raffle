// import dos domain
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

// import dos pacotes
import 'package:dartz/dartz.dart';

class TournamentUseCase {
  final TournamentRepo tournamentRepo;
  TournamentUseCase( this.tournamentRepo );

  Future<Either<Failure, List<TournamentEntity>>> getTournaments() async {
    return await tournamentRepo.getTournaments();
  }

  Future<Either<Failure, void>> updStatus( Map<String, dynamic> json ) async {
    return await tournamentRepo.updStatus( json );
  }

  Future<Either<Failure, void>> createTournament( Map<String, dynamic> json ) async {
    return await tournamentRepo.createTournament( json );
  }

  Future<Either<Failure, void>> updKey( Map<String, dynamic> json ) async {
    return await tournamentRepo.updKey( json );
  }

}