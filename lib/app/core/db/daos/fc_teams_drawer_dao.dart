// import dos pacotes
import 'package:fc_teams_drawer/domain/entity/fc_teams_drawer.dart';
import 'package:floor/floor.dart';

@dao
abstract class FcTeamsDrawerDao {

  @Query("SELECT * FROM fc_teams_drawer ORDER BY versionDataSync DESC LIMIT 1")
  Future<int?> getLastVersionDB();

  @insert
  Future<void> insertVersionDB( FcTeamsDrawerEntity entity );

}