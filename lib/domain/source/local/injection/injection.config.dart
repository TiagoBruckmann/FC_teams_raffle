// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fc_teams_drawer/app/core/db/local_db.dart' as _i4;
import 'package:fc_teams_drawer/data/datasource/team_remote_datasource.dart'
    as _i5;
import 'package:fc_teams_drawer/data/datasource/tournament_remote_datasource.dart'
    as _i8;
import 'package:fc_teams_drawer/data/repositories/team_repo_impl.dart' as _i6;
import 'package:fc_teams_drawer/data/repositories/tournament_repo_impl.dart'
    as _i9;
import 'package:fc_teams_drawer/data/utils/firebase_service.dart' as _i3;
import 'package:fc_teams_drawer/domain/usecases/team_usecase.dart' as _i7;
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart'
    as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.FirebaseService>(() => _i3.FirebaseService());
    gh.factory<_i4.LocalDb>(() => _i4.LocalDb());
    gh.factory<_i5.TeamRemoteDatasource>(() => _i5.TeamRemoteDatasourceImpl(
          gh<_i3.FirebaseService>(),
          gh<_i4.LocalDb>(),
        ));
    gh.factory<_i6.TeamRepo>(
        () => _i6.TeamRepoImpl(gh<_i5.TeamRemoteDatasource>()));
    gh.factory<_i7.TeamUseCase>(() => _i7.TeamUseCase(gh<_i6.TeamRepo>()));
    gh.factory<_i8.TournamentRemoteDatasource>(
        () => _i8.TournamentRemoteDatasourceImpl(gh<_i3.FirebaseService>()));
    gh.factory<_i9.TournamentRepo>(
        () => _i9.TournamentRepoImpl(gh<_i8.TournamentRemoteDatasource>()));
    gh.factory<_i10.TournamentUseCase>(
        () => _i10.TournamentUseCase(gh<_i9.TournamentRepo>()));
    return this;
  }
}
