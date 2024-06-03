import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@InjectableInit()
void configureDependencies() {

  // domain
  // getIt.registerFactory(() => UserUseCase(getIt()));

  // data
  // getIt.registerFactory<UserRemoteDatasource>(() => UserRemoteSourceImpl(getIt(), getIt(), getIt()));
  // getIt.registerFactory<UserRepo>(() => UserRepoImpl(getIt()));

  // extern
  getIt.registerFactory(() => FirebaseFirestore.instance);

}