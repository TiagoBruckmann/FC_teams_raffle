// import core
import 'dart:async';

import 'package:fc_teams_drawer/app/core/db/daos/fc_teams_drawer_dao.dart';
import 'package:fc_teams_drawer/app/core/db/daos/tournament_dao.dart';
import 'package:fc_teams_drawer/app/core/db/daos/player_dao.dart';
import 'package:fc_teams_drawer/app/core/db/daos/match_dao.dart';
import 'package:fc_teams_drawer/app/core/db/daos/team_dao.dart';
import 'package:fc_teams_drawer/app/core/db/daos/tournament_mapper.dart';
import 'package:fc_teams_drawer/domain/entity/tournament_mapper.dart';
import 'adapters/list_string_converter.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/fc_teams_drawer.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/team.dart';

// import dos pacotes
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

part 'local_db.g.dart';

const kDatabaseName = 'fc_teams_drawer.db';

@TypeConverters([ListStringConverter])
@Database(
  version: 1,
  entities: [
    TournamentMapperEntity,
    FcTeamsDrawerEntity,
    TournamentEntity,
    PlayerEntity,
    MatchEntity,
    TeamEntity,
  ],
)
abstract class LocalDb extends FloorDatabase {

  TournamentMapperDao get tournamentMapperDap;

  FcTeamsDrawerDao get fcTeamDrawerDao;

  TournamentDao get tournamentDao;

  PlayerDao get playerDao;

  MatchDao get matchDao;

  TeamDao get teamDao;

}