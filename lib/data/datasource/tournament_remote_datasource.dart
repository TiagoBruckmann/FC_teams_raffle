import 'package:fc_teams_drawer/app/core/db/collections/game.dart';
import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/session.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentCollection>> getTournaments();
  Future<void> createTournament( TournamentCollection tournament );

}

class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  TournamentRemoteDatasourceImpl();

  @override
  Future<List<TournamentCollection>> getTournaments() async {
    final response = await LocalDb().getGamesCollection();

    print("response => $response");
    print("response.listTournaments => ${response?.matches}");
    if ( response?.matches == null ) {
      return [];
    }

    return [response!];
  }

  @override
  Future<void> createTournament( TournamentCollection tournament ) async {

    if ( tournament.matches.isEmpty ) {
      Session.crash.onError("Failure on CreateTournament: Null ListTournament");
      throw CacheExceptions("Failure on CreateTournament: Null ListTournament");
    }

    await LocalDb().insertDb(object: tournament);

    return;

  }

}