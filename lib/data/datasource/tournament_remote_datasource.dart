import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:injectable/injectable.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentEntity>> getTournaments();
  Future<List<PlayerEntity>> getPlayers();
  Future<List<int>> createPlayers( List<PlayerEntity> players );
  Future<List<MatchEntity>> getMatches();
  Future<List<int>> createMatches( List<MatchEntity> matches );
  Future<void> createTournament( TournamentEntity tournament );
  Future<void> updateTournament( TournamentEntity tournament );

}

@Injectable(as: TournamentRemoteDatasource)
class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final LocalDb _localDb;
  TournamentRemoteDatasourceImpl( this._localDb );

  @override
  Future<List<TournamentEntity>> getTournaments() async {
    final response = await _localDb.tournamentDao.getAllTournaments();

    print("response => $response");
    response.removeWhere((tournament) => tournament.matchId.isEmpty || tournament.playerId.isEmpty);

    return response;
  }

  @override
  Future<List<PlayerEntity>> getPlayers() async {
    return await _localDb.playerDao.getAllPlayers();
  }

  @override
  Future<List<int>> createPlayers( List<PlayerEntity> players ) async {

    if ( players.isEmpty ) {
      Session.crash.onError("Failure on createPlayers: Empty ListPlayers");
      throw CacheExceptions("Failure on createPlayers: Empty ListPlayers");
    }

    return await _localDb.playerDao.insertAllPlayers(players);

  }

  @override
  Future<List<MatchEntity>> getMatches() async {
    return await _localDb.matchDao.getAllMatches();
  }

  @override
  Future<List<int>> createMatches( List<MatchEntity> matches ) async {

    if ( matches.isEmpty ) {
      Session.crash.onError("Failure on createMatches: Empty ListMatches");
      throw CacheExceptions("Failure on createMatches: Empty ListMatches");
    }

    return await _localDb.matchDao.insertAllMatches(matches);

  }

  @override
  Future<void> createTournament( TournamentEntity tournament ) async {

    if ( tournament.matchId.isEmpty ) {
      Session.crash.onError("Failure on CreateTournament: Null ListTournament");
      throw CacheExceptions("Failure on CreateTournament: Null ListTournament");
    }

    await _localDb.tournamentDao.insertTournament(tournament);

    return;

  }

  @override
  Future<void> updateTournament( TournamentEntity tournament ) async {

    if ( tournament.matchId.isEmpty ) {
      Session.crash.onError("Failure on CreateTournament: Null ListTournament");
      throw CacheExceptions("Failure on CreateTournament: Null ListTournament");
    }

    await _localDb.tournamentDao.updateTournament(tournament);

    return;

  }

}