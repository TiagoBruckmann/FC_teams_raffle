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

  Future<Either<Failure, void>> createOrUpdatePlayers( String tournamentId, List<PlayerEntity> players ) async {
    final List<Map<String, dynamic>> list = [];
    for ( final player in players ) {
      list.add(player.toJson());
    }

    final Map<String, dynamic> json = {
      "tournament_id": tournamentId,
      "players": list,
    };
    return await _tournamentRepo.createOrUpdatePlayers( json );
  }

  Future<Either<Failure, void>> createOrUpdateMatches( String tournamentId, List<MatchEntity> matches ) async {
    final List<Map<String, dynamic>> list = [];
    for ( final match in matches ) {
      list.add(match.toJson());
    }

    final Map<String, dynamic> json = {
      "tournament_id": tournamentId,
      "matches": list,
    };

    return await _tournamentRepo.createOrUpdateMatches( json );
  }


}