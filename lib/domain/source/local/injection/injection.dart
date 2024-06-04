import 'package:firebase_database/firebase_database.dart';
import 'package:fc_teams_drawer/data/datasource/team_remote_datasource.dart';
import 'package:fc_teams_drawer/data/repositories/team_repo_impl.dart';
import 'package:fc_teams_drawer/domain/repositories/team_repo.dart';
import 'package:fc_teams_drawer/domain/usecases/team_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@InjectableInit()
void configureDependencies() {

  // domain
  getIt.registerFactory(() => TeamUseCase(getIt()));

  // data
  getIt.registerFactory<TeamRemoteDatasource>(() => TeamRemoteDatasourceImpl(getIt()));
  getIt.registerFactory<TeamRepo>(() => TeamRepoImpl(getIt()));

  // extern
  getIt.registerFactory(() => FirebaseDatabase.instance);

}