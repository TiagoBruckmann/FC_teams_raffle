// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';

// import dos pacotes
import 'package:floor/floor.dart';

@dao
abstract class TournamentMapperDao {

  @Query("SELECT * FROM tournaments_mapper ORDER BY id DESC")
  Future<List<TournamentMapperEntity>> getAllTournamentsMapper();

  @Query("SELECT * FROM tournaments WHERE tournamentId = :tournamentId ORDER BY id DESC")
  Future<List<TournamentMapperEntity>> getTournamentMapperById( int tournamentId );

  @insert
  Future<int> insertTournamentMapper( TournamentMapperEntity tournaments );

  @update
  Future<void> updateTournamentMapper( TournamentMapperEntity tournament );

}