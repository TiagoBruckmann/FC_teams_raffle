// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fc_teams_drawer/app/core/db/local_db.dart' as _i681;
import 'package:fc_teams_drawer/data/datasource/team_remote_datasource.dart'
    as _i899;
import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart'
    as _i920;
import 'package:fc_teams_drawer/data/repositories/team_repo_impl.dart' as _i725;
import 'package:fc_teams_drawer/data/repositories/tournament_repo_impl.dart'
    as _i237;
import 'package:fc_teams_drawer/data/utils/firebase_service.dart' as _i760;
import 'package:fc_teams_drawer/domain/repositories/team_repo.dart' as _i571;
import 'package:fc_teams_drawer/domain/repositories/tournament_repo.dart'
    as _i813;
import 'package:fc_teams_drawer/domain/source/local/local_module.dart' as _i606;
import 'package:fc_teams_drawer/domain/source/local/secure_storage.dart'
    as _i28;
import 'package:fc_teams_drawer/domain/usecases/team_usecase.dart' as _i240;
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart'
    as _i156;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final localModule = _$LocalModule();
    gh.factory<_i760.FirebaseService>(() => _i760.FirebaseService());
    await gh.factoryAsync<_i681.LocalDb>(
      () => localModule.localDb(),
      preResolve: true,
    );
    gh.singleton<_i28.SecureStorageWrapper>(() => localModule.storageWrapper());
    gh.factory<_i899.TeamRemoteDatasource>(() => _i899.TeamRemoteDatasourceImpl(
          gh<_i28.SecureStorageWrapper>(),
          gh<_i760.FirebaseService>(),
          gh<_i681.LocalDb>(),
        ));
    gh.factory<_i920.TournamentRemoteDatasource>(
        () => _i920.TournamentRemoteDatasourceImpl(gh<_i681.LocalDb>()));
    gh.factory<_i813.TournamentRepo>(
        () => _i237.TournamentRepoImpl(gh<_i920.TournamentRemoteDatasource>()));
    gh.factory<_i571.TeamRepo>(
        () => _i725.TeamRepoImpl(gh<_i899.TeamRemoteDatasource>()));
    gh.factory<_i240.TeamUseCase>(
        () => _i240.TeamUseCase(gh<_i571.TeamRepo>()));
    gh.factory<_i156.TournamentUseCase>(
        () => _i156.TournamentUseCase(gh<_i813.TournamentRepo>()));
    return this;
  }
}

class _$LocalModule extends _i606.LocalModule {}
