// import dos domain
import 'package:fc_teams_drawer/data/repositories/tournament_repo_impl.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';

// import dos pacotes
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@injectable
class TournamentUseCase {
  final TournamentRepo _tournamentRepo;
  TournamentUseCase( this._tournamentRepo );

  Future<Either<Failure, void>> createTournament( TournamentEntity tournament ) async {
    return await _tournamentRepo.createTournament( tournament.toJson() );
  }

  Future<Either<Failure, void>> updateTournament( TournamentEntity tournament ) async {
    return await _tournamentRepo.updateTournament( tournament.toJson() );
  }

  Future<Either<Failure, List<TournamentEntity>>> getTournaments() async {
    return await _tournamentRepo.getTournaments();
  }

  Future<Either<Failure, TournamentEntity?>> getTournamentById( String tournamentId ) async {
    return await _tournamentRepo.getTournamentById(tournamentId);
  }

  Future<Either<Failure, void>> createPlayer( String tournamentId, PlayerEntity player ) async {
    final Map<String, dynamic> json = player.toJson({
      "tournament_id": tournamentId,
    });
    return await _tournamentRepo.createPlayer( json );
  }

  Future<Either<Failure, void>> updatePlayer( String tournamentId, PlayerEntity player ) async {
    final Map<String, dynamic> json = player.toJson({
      "tournament_id": tournamentId,
    });
    return await _tournamentRepo.updatePlayer( json );
  }

  Future<Either<Failure, void>> createMatches( String tournamentId, List<MatchEntity> matches ) async {
    final Map<String, dynamic> json = {
      "tournament_id": tournamentId,
    };

    for ( final match in matches ) {
      json.addAll({
        "matches": match.toJson(),
      });
    }

    return await _tournamentRepo.createMatches( json );
  }

  Future<Either<Failure, void>> updateMatches( String tournamentId, List<MatchEntity> matches ) async {
    final Map<String, dynamic> json = {
      "tournament_id": tournamentId,
    };

    for ( final match in matches ) {
      json.addAll({
        "matches": match.toJson(),
      });
    }

    return await _tournamentRepo.updateMatches( json );
  }

}