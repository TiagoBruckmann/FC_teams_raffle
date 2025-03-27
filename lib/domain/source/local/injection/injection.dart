import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async {

  GetIt.I.registerFactory(() => LocalDb());

  getIt.init();
}