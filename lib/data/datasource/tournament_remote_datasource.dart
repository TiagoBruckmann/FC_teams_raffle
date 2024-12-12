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
  Future<TournamentEntity?> getTournamentById( int tournamentId );
  Future<List<PlayerEntity>> getPlayers();
  Future<List<int>> createPlayers( List<PlayerEntity> players );
  Future<List<MatchEntity>> getMatches();
  Future<List<int>> createMatches( List<MatchEntity> matches );
  Future<int> createTournament( TournamentEntity tournament );
  Future<void> updateTournament( TournamentEntity tournament );
  Future<List<int>> createTournamentMapper( List<TournamentMapperEntity> mappers );

}

@Injectable(as: TournamentRemoteDatasource)
class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final LocalDb _localDb;
  TournamentRemoteDatasourceImpl( this._localDb );

  @override
  Future<List<TournamentModel>> getTournaments() async {
    final responseMapper = await _localDb.tournamentMapperDap.getAllTournamentsMapper();

    final List<TournamentModel> listTournaments = [];
    final List<PlayerEntity> listPlayers = [];
    final List<MatchEntity> listMatches = [];
    TournamentEntity? tournament;

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

      if ( mapper.playerId != null ) {
        final responsePlayers = await _localDb.playerDao.getPlayerById(mapper.playerId!);
        if ( responsePlayers != null ) {
          listPlayers.add(responsePlayers);
        }
      }

      if ( mapper.matchId != null ) {
        final responseMatches = await _localDb.matchDao.getMatchById(mapper.matchId!);
        if ( responseMatches != null ) {
          listMatches.add(responseMatches);
        }
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

    final list = listTournaments.toSet().toList();

    return list;
  }

  @override
  Future<TournamentEntity?> getTournamentById( int tournamentId ) async {
    return await _localDb.tournamentDao.getTournamentById(tournamentId);
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
  Future<List<int>> createTournamentMapper( List<TournamentMapperEntity> mappers ) async {
    return await _localDb.tournamentMapperDap.insertTournamentMapper(mappers);
  }

}