// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:floor/floor.dart';

@dao
abstract class TournamentDao {

  @Query("SELECT * FROM tournaments ORDER BY id DESC")
  Future<List<TournamentEntity>> getAllTournaments();

  @Query("SELECT * FROM tournaments WHERE id = :matchId ORDER BY id DESC")
  Future<List<TournamentEntity>> getTournamentById( int matchId );

  @insert
  Future<int> insertTournament( TournamentEntity tournaments );

  @update
  Future<void> updateTournament( TournamentEntity tournament );

}