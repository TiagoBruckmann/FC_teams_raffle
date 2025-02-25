import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {

  @preResolve
  Future<LocalDb> localDb() => $FloorLocalDb.databaseBuilder(kDatabaseName).build();

}