// import dos domain
import 'package:fc_teams_drawer/domain/repositories/team_repo.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

// import dos pacotes
import 'package:dartz/dartz.dart';

class TeamUseCase {
  final TeamRepo teamRepo;
  TeamUseCase( this.teamRepo );

  Future<Either<Failure, void>> getDataSync() async {
    return await teamRepo.getDataSync();
  }

}