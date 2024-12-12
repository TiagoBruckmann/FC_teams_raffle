// import dos domain
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

// import dos pacotes
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@injectable
class TournamentUseCase {
  final TournamentRepo _tournamentRepo;
  TournamentUseCase( this._tournamentRepo );

  Future<Either<Failure, List<TournamentEntity>>> getTournaments() async {
    return await _tournamentRepo.getTournaments();
  }

  Future<Either<Failure, TournamentEntity?>> getTournamentById( int tournamentId ) async {
    return await _tournamentRepo.getTournamentById(tournamentId);
  }

  Future<Either<Failure, List<PlayerEntity>>> getPlayers() async {
    return await _tournamentRepo.getPlayers();
  }

  Future<Either<Failure, List<int>>> createPlayers( List<PlayerEntity> players ) async {
    return await _tournamentRepo.createPlayers( players );
  }

  Future<Either<Failure, List<MatchEntity>>> getMatches() async {
    return await _tournamentRepo.getMatches();
  }

  Future<Either<Failure, List<int>>> createMatches( List<MatchEntity> matches ) async {
    return await _tournamentRepo.createMatches( matches );
  }

  Future<Either<Failure, int>> createTournament( TournamentEntity tournament ) async {
    return await _tournamentRepo.createTournament( tournament );
  }

  Future<Either<Failure, void>> updateTournament( TournamentEntity tournament ) async {
    return await _tournamentRepo.updateTournament( tournament );
  }

  Future<Either<Failure, List<int>>> createTournamentMapper( List<TournamentMapperEntity> mappers ) async {
    return await _tournamentRepo.createTournamentMapper( mappers );
  }

}