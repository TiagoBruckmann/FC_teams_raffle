import 'package:fc_teams_drawer/app/core/db/collections/tournament.dart';
import 'package:fc_teams_drawer/app/core/db/local_db.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/session.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentCollection>> getTournaments();
  Future<void> createTournament( Map<String, dynamic> json );
  Future<void> updAllKey( GamesCollection game );

}

class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  TournamentRemoteDatasourceImpl();

  @override
  Future<List<TournamentCollection>> getTournaments() async {
    final response = await LocalDb().getGamesCollection();

    if ( response?.listTournaments == null ) {
      return [];
    }

    Session.gamesCollection = response!;
    return response.listTournaments!;
  }

  @override
  Future<void> createTournament( Map<String, dynamic> json ) async {

    final game = GamesCollection.fromJson(json);
    Session.gamesCollection.listTournaments?.addAll(game.listTournaments!);

    if ( game.listTournaments == null  ) {
      Session.crash.onError("Failure on CreateTournament: Null ListTournament");
      throw CacheExceptions("Failure on CreateTournament: Null ListTournament");
    }

    final isSuccessSyncDataModel = await LocalDb().syncTournamentDataModel(Session.gamesCollection);

    if ( !isSuccessSyncDataModel ) {
      Session.crash.onError("Failure on Sync Games data model");
      throw CacheExceptions("Failure on Sync Games data model");
    }

    print("Session.gamesCollection => ${Session.gamesCollection}");
    print("Session.gamesCollection.listTournaments => ${Session.gamesCollection.listTournaments}");
    Session.gamesCollection.listTournaments?.addAll(game.listTournaments!);
    return;

  }

  @override
  Future<void> updAllKey( GamesCollection game ) async {

    final isSuccessSyncDataModel = await LocalDb().syncTournamentDataModel(game);

    if ( !isSuccessSyncDataModel ) {
      Session.crash.onError("Failure on Sync Games data model");
      throw CacheExceptions("Failure on Sync Games data model");
    }

    return;
  }

}