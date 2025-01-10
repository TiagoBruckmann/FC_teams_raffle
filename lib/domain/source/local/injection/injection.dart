import 'package:fc_teams_drawer/domain/source/local/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();