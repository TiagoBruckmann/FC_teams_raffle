// import dos data
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:floor/floor.dart';

@dao
abstract class PlayerDao {

  @Query("SELECT * FROM players")
  Future<List<PlayerEntity>> getAllPlayers();

  @Query("SELECT * FROM players WHERE id = :playerId")
  Future<PlayerEntity?> getPlayerById( int playerId );

  @insert
  Future<List<int>> insertAllPlayers( List<PlayerEntity> players );

  @update
  Future<void> updatePlayer( PlayerEntity player );

}