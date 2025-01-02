// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $LocalDbBuilderContract {
  /// Adds migrations to the builder.
  $LocalDbBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $LocalDbBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<LocalDb> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorLocalDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $LocalDbBuilderContract databaseBuilder(String name) =>
      _$LocalDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $LocalDbBuilderContract inMemoryDatabaseBuilder() =>
      _$LocalDbBuilder(null);
}

class _$LocalDbBuilder implements $LocalDbBuilderContract {
  _$LocalDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $LocalDbBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $LocalDbBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<LocalDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LocalDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$LocalDb extends LocalDb {
  _$LocalDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TournamentMapperDao? _tournamentMapperDapInstance;

  FcTeamsDrawerDao? _fcTeamDrawerDaoInstance;

  TournamentDao? _tournamentDaoInstance;

  PlayerDao? _playerDaoInstance;

  MatchDao? _matchDaoInstance;

  TeamDao? _teamDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tournaments_mapper` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `tournamentId` INTEGER NOT NULL, `playerId` INTEGER, `matchId` INTEGER, FOREIGN KEY (`tournamentId`) REFERENCES `tournaments` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`playerId`) REFERENCES `players` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`matchId`) REFERENCES `matches` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fc_teams_drawer` (`versionDataSync` INTEGER NOT NULL, PRIMARY KEY (`versionDataSync`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tournaments` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `date` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `drawTeams` INTEGER NOT NULL, `isActive` INTEGER NOT NULL, `defeats` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `players` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `team` TEXT NOT NULL, `losses` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `matches` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `player1` TEXT NOT NULL, `logoTeam1` TEXT NOT NULL, `player2` TEXT NOT NULL, `logoTeam2` TEXT NOT NULL, `winner` TEXT NOT NULL, `round` INTEGER NOT NULL, `score1` INTEGER, `score2` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `league` TEXT NOT NULL, `logo` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TournamentMapperDao get tournamentMapperDap {
    return _tournamentMapperDapInstance ??=
        _$TournamentMapperDao(database, changeListener);
  }

  @override
  FcTeamsDrawerDao get fcTeamDrawerDao {
    return _fcTeamDrawerDaoInstance ??=
        _$FcTeamsDrawerDao(database, changeListener);
  }

  @override
  TournamentDao get tournamentDao {
    return _tournamentDaoInstance ??= _$TournamentDao(database, changeListener);
  }

  @override
  PlayerDao get playerDao {
    return _playerDaoInstance ??= _$PlayerDao(database, changeListener);
  }

  @override
  MatchDao get matchDao {
    return _matchDaoInstance ??= _$MatchDao(database, changeListener);
  }

  @override
  TeamDao get teamDao {
    return _teamDaoInstance ??= _$TeamDao(database, changeListener);
  }
}

class _$TournamentMapperDao extends TournamentMapperDao {
  _$TournamentMapperDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tournamentMapperEntityInsertionAdapter = InsertionAdapter(
            database,
            'tournaments_mapper',
            (TournamentMapperEntity item) => <String, Object?>{
                  'id': item.id,
                  'tournamentId': item.tournamentId,
                  'playerId': item.playerId,
                  'matchId': item.matchId
                }),
        _tournamentMapperEntityUpdateAdapter = UpdateAdapter(
            database,
            'tournaments_mapper',
            ['id'],
            (TournamentMapperEntity item) => <String, Object?>{
                  'id': item.id,
                  'tournamentId': item.tournamentId,
                  'playerId': item.playerId,
                  'matchId': item.matchId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TournamentMapperEntity>
      _tournamentMapperEntityInsertionAdapter;

  final UpdateAdapter<TournamentMapperEntity>
      _tournamentMapperEntityUpdateAdapter;

  @override
  Future<List<TournamentMapperEntity>> getAllTournamentsMapper() async {
    return _queryAdapter.queryList(
        'SELECT * FROM tournaments_mapper ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => TournamentMapperEntity(
            row['tournamentId'] as int,
            id: row['id'] as int?,
            playerId: row['playerId'] as int?,
            matchId: row['matchId'] as int?));
  }

  @override
  Future<List<TournamentMapperEntity>> getTournamentMapperById(
      int tournamentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tournaments WHERE tournamentId = ?1 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => TournamentMapperEntity(
            row['tournamentId'] as int,
            id: row['id'] as int?,
            playerId: row['playerId'] as int?,
            matchId: row['matchId'] as int?),
        arguments: [tournamentId]);
  }

  @override
  Future<List<int>> insertTournamentMapper(
      List<TournamentMapperEntity> mappers) {
    return _tournamentMapperEntityInsertionAdapter.insertListAndReturnIds(
        mappers, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTournamentMapper(TournamentMapperEntity tournament) async {
    await _tournamentMapperEntityUpdateAdapter.update(
        tournament, OnConflictStrategy.abort);
  }
}

class _$FcTeamsDrawerDao extends FcTeamsDrawerDao {
  _$FcTeamsDrawerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _fcTeamsDrawerEntityInsertionAdapter = InsertionAdapter(
            database,
            'fc_teams_drawer',
            (FcTeamsDrawerEntity item) =>
                <String, Object?>{'versionDataSync': item.versionDataSync});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FcTeamsDrawerEntity>
      _fcTeamsDrawerEntityInsertionAdapter;

  @override
  Future<int?> getLastVersionDB() async {
    return _queryAdapter.query(
        'SELECT * FROM fc_teams_drawer ORDER BY versionDataSync DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> insertVersionDB(FcTeamsDrawerEntity entity) {
    return _fcTeamsDrawerEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }
}

class _$TournamentDao extends TournamentDao {
  _$TournamentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tournamentEntityInsertionAdapter = InsertionAdapter(
            database,
            'tournaments',
            (TournamentEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'createdAt': item.createdAt,
                  'drawTeams': item.drawTeams ? 1 : 0,
                  'isActive': item.isActive ? 1 : 0,
                  'defeats': item.defeats
                }),
        _tournamentEntityUpdateAdapter = UpdateAdapter(
            database,
            'tournaments',
            ['id'],
            (TournamentEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'createdAt': item.createdAt,
                  'drawTeams': item.drawTeams ? 1 : 0,
                  'isActive': item.isActive ? 1 : 0,
                  'defeats': item.defeats
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TournamentEntity> _tournamentEntityInsertionAdapter;

  final UpdateAdapter<TournamentEntity> _tournamentEntityUpdateAdapter;

  @override
  Future<List<TournamentEntity>> getAllTournaments() async {
    return _queryAdapter.queryList('SELECT * FROM tournaments ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => TournamentEntity(
            row['name'] as String,
            row['date'] as String,
            (row['drawTeams'] as int) != 0,
            (row['isActive'] as int) != 0,
            row['defeats'] as int,
            row['createdAt'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<TournamentEntity?> getTournamentById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM tournaments WHERE id = ?1 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => TournamentEntity(
            row['name'] as String,
            row['date'] as String,
            (row['drawTeams'] as int) != 0,
            (row['isActive'] as int) != 0,
            row['defeats'] as int,
            row['createdAt'] as String,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<int> insertTournament(TournamentEntity tournaments) {
    return _tournamentEntityInsertionAdapter.insertAndReturnId(
        tournaments, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTournament(TournamentEntity tournament) async {
    await _tournamentEntityUpdateAdapter.update(
        tournament, OnConflictStrategy.abort);
  }
}

class _$PlayerDao extends PlayerDao {
  _$PlayerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _playerEntityInsertionAdapter = InsertionAdapter(
            database,
            'players',
            (PlayerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'team': item.team,
                  'losses': item.losses
                }),
        _playerEntityUpdateAdapter = UpdateAdapter(
            database,
            'players',
            ['id'],
            (PlayerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'team': item.team,
                  'losses': item.losses
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlayerEntity> _playerEntityInsertionAdapter;

  final UpdateAdapter<PlayerEntity> _playerEntityUpdateAdapter;

  @override
  Future<List<PlayerEntity>> getAllPlayers() async {
    return _queryAdapter.queryList('SELECT * FROM players',
        mapper: (Map<String, Object?> row) => PlayerEntity(
            row['name'] as String, row['team'] as String, row['losses'] as int,
            id: row['id'] as int?));
  }

  @override
  Future<PlayerEntity?> getPlayerById(int playerId) async {
    return _queryAdapter.query('SELECT * FROM players WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PlayerEntity(
            row['name'] as String, row['team'] as String, row['losses'] as int,
            id: row['id'] as int?),
        arguments: [playerId]);
  }

  @override
  Future<List<int>> insertAllPlayers(List<PlayerEntity> players) {
    return _playerEntityInsertionAdapter.insertListAndReturnIds(
        players, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlayer(PlayerEntity player) async {
    await _playerEntityUpdateAdapter.update(player, OnConflictStrategy.abort);
  }
}

class _$MatchDao extends MatchDao {
  _$MatchDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _matchEntityInsertionAdapter = InsertionAdapter(
            database,
            'matches',
            (MatchEntity item) => <String, Object?>{
                  'id': item.id,
                  'player1': item.player1,
                  'logoTeam1': item.logoTeam1,
                  'player2': item.player2,
                  'logoTeam2': item.logoTeam2,
                  'winner': item.winner,
                  'round': item.round,
                  'score1': item.score1,
                  'score2': item.score2
                }),
        _matchEntityUpdateAdapter = UpdateAdapter(
            database,
            'matches',
            ['id'],
            (MatchEntity item) => <String, Object?>{
                  'id': item.id,
                  'player1': item.player1,
                  'logoTeam1': item.logoTeam1,
                  'player2': item.player2,
                  'logoTeam2': item.logoTeam2,
                  'winner': item.winner,
                  'round': item.round,
                  'score1': item.score1,
                  'score2': item.score2
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MatchEntity> _matchEntityInsertionAdapter;

  final UpdateAdapter<MatchEntity> _matchEntityUpdateAdapter;

  @override
  Future<List<MatchEntity>> getAllMatches() async {
    return _queryAdapter.queryList('SELECT * FROM matches ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => MatchEntity(
            row['player1'] as String,
            row['logoTeam1'] as String,
            row['player2'] as String,
            row['logoTeam2'] as String,
            row['winner'] as String,
            row['round'] as int,
            id: row['id'] as int?,
            score1: row['score1'] as int?,
            score2: row['score2'] as int?));
  }

  @override
  Future<MatchEntity?> getMatchById(int matchId) async {
    return _queryAdapter.query(
        'SELECT * FROM matches WHERE id = ?1 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => MatchEntity(
            row['player1'] as String,
            row['logoTeam1'] as String,
            row['player2'] as String,
            row['logoTeam2'] as String,
            row['winner'] as String,
            row['round'] as int,
            id: row['id'] as int?,
            score1: row['score1'] as int?,
            score2: row['score2'] as int?),
        arguments: [matchId]);
  }

  @override
  Future<MatchEntity?> getMatchByPlayer1AndPlayer2(
    String player1,
    String player2,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM matches WHERE player1 = ?1 AND player2 = ?2 ORDER BY id DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => MatchEntity(row['player1'] as String, row['logoTeam1'] as String, row['player2'] as String, row['logoTeam2'] as String, row['winner'] as String, row['round'] as int, id: row['id'] as int?, score1: row['score1'] as int?, score2: row['score2'] as int?),
        arguments: [player1, player2]);
  }

  @override
  Future<List<int>> insertAllMatches(List<MatchEntity> matches) {
    return _matchEntityInsertionAdapter.insertListAndReturnIds(
        matches, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMatches(List<MatchEntity> matches) async {
    await _matchEntityUpdateAdapter.updateList(
        matches, OnConflictStrategy.abort);
  }
}

class _$TeamDao extends TeamDao {
  _$TeamDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _teamEntityInsertionAdapter = InsertionAdapter(
            database,
            'teams',
            (TeamEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'league': item.league,
                  'logo': item.logo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TeamEntity> _teamEntityInsertionAdapter;

  @override
  Future<List<TeamEntity>> getAllTeams() async {
    return _queryAdapter.queryList('SELECT * FROM teams',
        mapper: (Map<String, Object?> row) => TeamEntity(row['name'] as String,
            row['league'] as String, row['logo'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<void> insertAllTeams(List<TeamEntity> teams) async {
    await _teamEntityInsertionAdapter.insertList(
        teams, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _listStringConverter = ListStringConverter();
