// import dos data
import 'package:fc_teams_drawer/domain/entity/match.dart';

// import dos pacotes
import 'package:floor/floor.dart';

@dao
abstract class MatchDao {

  @Query("SELECT * FROM matches ORDER BY id DESC")
  Future<List<MatchEntity>> getAllMatches();

  @Query("SELECT * FROM matches WHERE id = :matchId ORDER BY id DESC")
  Future<MatchEntity?> getMatchById( int matchId );

  @Query("SELECT * FROM matches WHERE player1 = :player1 AND player2 = :player2 ORDER BY id DESC LIMIT 1")
  Future<MatchEntity?> getMatchByPlayer1AndPlayer2( String player1, String player2 );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> createOrUpdateMatches( List<MatchEntity> matches );

}