// import dos data
import 'package:fc_teams_drawer/domain/entity/team.dart';

// import dos pacotes
import 'package:floor/floor.dart';

@dao
abstract class TeamDao {

  @Query("SELECT * FROM teams")
  Future<List<TeamEntity>> getAllTeams();

  @insert
  Future<void> insertAllTeams( List<TeamEntity> teams );

}