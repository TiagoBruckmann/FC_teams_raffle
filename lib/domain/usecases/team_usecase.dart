// import dos domain
import 'package:fc_teams_drawer/domain/repositories/team_repo.dart';
import 'package:fc_teams_drawer/domain/failures/failures.dart';

// import dos pacotes
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@injectable
class TeamUseCase {
  final TeamRepo _teamRepo;
  TeamUseCase( this._teamRepo );

  Future<Either<Failure, void>> getDataSync() async {
    return await _teamRepo.getDataSync();
  }

}