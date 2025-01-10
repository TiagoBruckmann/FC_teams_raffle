import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/domain/source/local/secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {

  @singleton
  SecureStorageWrapper storageWrapper() => SecureStorageWrapper();

  @preResolve
  Future<LocalDb> localDb() => $FloorLocalDb.databaseBuilder(kDatabaseName).build();

}