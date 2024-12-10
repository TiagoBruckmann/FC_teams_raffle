import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:injectable/injectable.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentModel>> getTournaments();
  Future<List<PlayerEntity>> getPlayers();
  Future<List<int>> createPlayers( List<PlayerEntity> players );
  Future<List<MatchEntity>> getMatches();
  Future<List<int>> createMatches( List<MatchEntity> matches );
  Future<int> createTournament( TournamentEntity tournament );
  Future<void> updateTournament( TournamentEntity tournament );
  Future<int> createTournamentMapper( TournamentMapperEntity tournament );

}

@Injectable(as: TournamentRemoteDatasource)
class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final LocalDb _localDb;
  TournamentRemoteDatasourceImpl( this._localDb );

  @override
  Future<List<TournamentModel>> getTournaments() async {
    final responseMapper = await _localDb.tournamentMapperDap.getAllTournamentsMapper();

    final List<TournamentModel> listTournaments = [];
    late TournamentEntity? tournament;
    final List<PlayerEntity> listPlayers = [];
    final List<MatchEntity> listMatches = [];

    int tournamentId = 0;

    for ( final mapper in responseMapper ) {

      if ( tournamentId != mapper.tournamentId ) {
        tournamentId = mapper.tournamentId;
        
        if ( tournament != null && listPlayers.isNotEmpty && listMatches.isNotEmpty ) {
          listTournaments.add(
            TournamentModel.fromQuery(tournament, listPlayers, listMatches),
          );
        }
        
        listPlayers.clear();
        listMatches.clear();

        tournament = await _localDb.tournamentDao.getTournamentById(tournamentId);
      }

      final responsePlayers = await _localDb.playerDao.getPlayerById(mapper.playerId);
      if ( responsePlayers != null ) {
        listPlayers.add(responsePlayers);
      }

      final responseMatches = await _localDb.matchDao.getMatchById(mapper.matchId);
      if ( responseMatches != null ) {
        listMatches.add(responseMatches);
      }
    }
    
    final containsLastId = listTournaments.where((TournamentModel tournament) => tournament.id == tournamentId );
    if ( containsLastId.isEmpty && tournament != null ) {
      listTournaments.add(
        TournamentModel.fromQuery(tournament, listPlayers, listMatches),
      );

      listPlayers.clear();
      listMatches.clear();

    }

    print("listTournaments => $listTournaments");
    final list = listTournaments.toSet().toList();
    print("list => $list");

    return list;
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
  Future<int> createTournament( TournamentEntity tournament ) async {
    return await _localDb.tournamentDao.insertTournament(tournament);
  }

  @override
  Future<void> updateTournament( TournamentEntity tournament ) async {
    return await _localDb.tournamentDao.updateTournament(tournament);
  }

  @override
  Future<int> createTournamentMapper( TournamentMapperEntity tournament ) async {
    return await _localDb.tournamentMapperDap.insertTournamentMapper(tournament);
  }

}