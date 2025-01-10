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
  Future<void> updatePlayer( PlayerEntity player );
  Future<List<MatchEntity>> getMatches();
  Future<List<int>> createOrUpdateMatches( List<MatchEntity> matches );
  Future<int> createTournament( TournamentEntity tournament );
  Future<void> updateTournament( TournamentEntity tournament );
  Future<List<int>> createOrUpdateTournamentMapper( List<TournamentMapperEntity> mappers );

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
    int tournamentId = responseMapper.first.tournamentId;

    for ( int i = 0; i < responseMapper.length; i++ ) {

      final mapper = responseMapper[i];

      tournament = await _localDb.tournamentDao.getTournamentById(tournamentId);

      if ( mapper.playerId != null ) {
        final responsePlayers = await _localDb.playerDao.getPlayerById(mapper.playerId!);
        if ( responsePlayers != null ) {
          listPlayers.add(responsePlayers);
        }
      }

      if ( mapper.matchId != null ) {
        final responseMatch = await _localDb.matchDao.getMatchById(mapper.matchId!);

        if ( responseMatch != null ) {
          final index = listMatches.indexWhere((match) => match.hasRound(responseMatch));
          if ( index.isNegative ) {
            listMatches.add(responseMatch);
          }

          if ( !responseMatch.isLoserOrWinner() && responseMatch.isScoreNotNull() && !index.isNegative ) {
            listMatches.removeAt(index);
            listMatches.insert(index, responseMatch);
          }

        }
      }

      bool hasMoreItems = false;
      TournamentMapperEntity? nextEntity;
      if ( ( i + 1 ) <= responseMapper.length - 1 ) {
        hasMoreItems = true;
        nextEntity = responseMapper[i + 1];
      }

      if ( tournament != null ) {

        if ( !hasMoreItems && nextEntity == null ) {
          listMatches.sort((a, b) => b.round.compareTo(a.round));
          listTournaments.add(
            TournamentModel.fromQuery(tournament, List.from(listPlayers), List.from(listMatches)),
          );

          listPlayers.clear();
          listMatches.clear();
          break;
        }

        if ( tournamentId != nextEntity!.tournamentId ) {
          tournamentId = nextEntity.tournamentId;
          listMatches.sort((a, b) => b.round.compareTo(a.round));

          listTournaments.add(
            TournamentModel.fromQuery(tournament, List.from(listPlayers), List.from(listMatches)),
          );

          listPlayers.clear();
          listMatches.clear();

        }

      }

    }

    return listTournaments;
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
  Future<void> updatePlayer( PlayerEntity player ) async {
    return await _localDb.playerDao.updatePlayer(player);
  }

  @override
  Future<List<MatchEntity>> getMatches() async {
    final matches = await _localDb.matchDao.getAllMatches();

    matches.sort((a, b) => b.round.compareTo(a.round));

    return matches;
  }

  @override
  Future<List<int>> createOrUpdateMatches( List<MatchEntity> matches ) async {

    if ( matches.isEmpty ) {
      Session.crash.onError("Failure on createMatches: Empty ListMatches");
      throw CacheExceptions("Failure on createMatches: Empty ListMatches");
    }

    return await _localDb.matchDao.createOrUpdateMatches(matches);
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
  Future<List<int>> createOrUpdateTournamentMapper( List<TournamentMapperEntity> mappers ) async {
    return await _localDb.tournamentMapperDap.insertOrUpdateTournamentMapper(mappers);
  }

}