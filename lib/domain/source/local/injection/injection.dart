import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart';
import 'package:fc_teams_drawer/data/repositories/tournament_repo_impl.dart';
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
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
  getIt.registerFactory(() => TournamentUseCase(getIt()));
  getIt.registerFactory(() => TeamUseCase(getIt()));

  // data
  getIt.registerFactory<TournamentRemoteDatasource>(() => TournamentRemoteDatasourceImpl(getIt()));
  getIt.registerFactory<TeamRemoteDatasource>(() => TeamRemoteDatasourceImpl(getIt()));
  getIt.registerFactory<TournamentRepo>(() => TournamentRepoImpl(getIt()));
  getIt.registerFactory<TeamRepo>(() => TeamRepoImpl(getIt()));

  // extern
  getIt.registerFactory(() => FirebaseDatabase.instance);

}