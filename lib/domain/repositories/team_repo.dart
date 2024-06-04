import 'package:dartz/dartz.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

abstract class TeamRepo {

  Future<Either<Failure, void>> getDataSync();

}