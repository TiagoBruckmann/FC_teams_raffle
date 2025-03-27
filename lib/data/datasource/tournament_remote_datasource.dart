import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/match_model.dart';
import 'package:fc_teams_drawer/data/model/player_model.dart';
import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:fc_teams_drawer/data/utils/firebase_service.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:injectable/injectable.dart';

abstract class TournamentRemoteDatasource {

  Future<void> createTournament( Map<String, dynamic> json );
  Future<void> updateTournament( Map<String, dynamic> json );
  Future<List<TournamentModel>> getTournaments();
  Future<TournamentEntity?> getTournamentById( String tournamentId );
  Future<void> createPlayer( Map<String, dynamic> json );
  Future<void> updatePlayer( Map<String, dynamic> json );
  Future<void> createMatch( Map<String, dynamic> json );
  Future<void> updateMatch( Map<String, dynamic> json );

}

@Injectable(as: TournamentRemoteDatasource)
class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final FirebaseService _firebaseService;
  TournamentRemoteDatasourceImpl( this._firebaseService );

  @override
  Future<void> createTournament( Map<String, dynamic> json ) async {
    final base = await _firebaseService.getTournamentBaseUrl();

    await base
      .doc(json["id"])
      .set(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

  @override
  Future<void> updateTournament( Map<String, dynamic> json ) async {
    final base = await _firebaseService.getTournamentBaseUrl();

    await base
      .doc(json["id"])
      .update(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

  @override
  Future<List<TournamentModel>> getTournaments() async {
    final base = await _firebaseService.getTournamentBaseUrl();

    try {

      final List<TournamentModel> tournaments = [];

      await base
        .get()
        .then((value) async {

          final List<PlayerModel> players = [];
          final List<MatchModel> matches = [];

          for ( final item in value.docs ) {

            await item.reference
            .collection("players")
            .get()
            .then((items) {

              for ( final item in items.docs ) {
                players.add(
                  PlayerModel.fromJson(item.data()),
                );
              }

            })
            .onError((error, stackTrace) {
              Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
              throw ServerExceptions(error.toString());
            })
            .catchError((onError) {
              Session.crash.log(onError);
              throw ServerExceptions(onError.toString());
            });

            await item.reference
            .collection("matches")
            .get()
            .then((items) {

              for ( final item in items.docs ) {
                matches.add(
                  MatchModel.fromJson(item.data()),
                );
              }

            })
            .onError((error, stackTrace) {
              Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
              throw ServerExceptions(error.toString());
            })
            .catchError((onError) {
              Session.crash.log(onError);
              throw ServerExceptions(onError.toString());
            });

            tournaments.add(
              TournamentModel.fromJson(item.data(), players, matches),
            );
          }

        })
        .onError((error, stackTrace) {
          Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
          throw ServerExceptions(error.toString());
        })
        .catchError((onError) {
          Session.crash.log(onError);
          throw ServerExceptions(onError.toString());
        });

      return tournaments;

    } catch (e) {
      Session.logs.errorLog("getTournaments failure => ${e.toString()}");
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<TournamentEntity?> getTournamentById( String tournamentId ) async {

    final base = await _firebaseService.getTournamentBaseUrl();

    late TournamentModel tournament;

    await base
      .doc(tournamentId)
      .get()
      .then((value) async {
  
        final List<PlayerModel> players = [];
        final List<MatchModel> matches = [];
  
        await value.reference
          .collection("players")
          .get()
          .then((items) {
    
            for ( final item in items.docs ) {
              players.add(
                PlayerModel.fromJson(item.data()),
              );
            }
    
          })
          .onError((error, stackTrace) {
            Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
            throw ServerExceptions(error.toString());
          })
          .catchError((onError) {
            Session.crash.log(onError);
            throw ServerExceptions(onError.toString());
          });
  
        await value.reference
          .collection("matches")
          .get()
          .then((items) {
    
            for ( final item in items.docs ) {
              matches.add(
                MatchModel.fromJson(item.data()),
              );
            }
    
          })
          .onError((error, stackTrace) {
            Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
            throw ServerExceptions(error.toString());
          })
          .catchError((onError) {
            Session.crash.log(onError);
            throw ServerExceptions(onError.toString());
          });
  
        if ( value.data() != null ) {
          tournament = TournamentModel.fromJson(value.data()!, players, matches);
        }
  
      })
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return tournament;
  }

  @override
  Future<void> createPlayer( Map<String, dynamic> json ) async {
    final base = await _firebaseService.getTournamentBaseUrl();

    final tournamentId = json["tournament_id"];
    json.remove("tournament_id");
    
    await base
      .doc(tournamentId)
      .collection("players")
      .doc(json["id"])
      .set(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

  @override
  Future<void> updatePlayer( Map<String, dynamic> json ) async {
    final base = await _firebaseService.getTournamentBaseUrl();

    final tournamentId = json["tournament_id"];
    json.remove("tournament_id");

    await base
      .doc(tournamentId)
      .collection("players")
      .doc(json["id"])
      .update(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

  @override
  Future<void> createMatch( Map<String, dynamic> json ) async {
    final base = await _firebaseService.getTournamentBaseUrl();

    final tournamentId = json["tournament_id"];
    json.remove("tournament_id");

    await base
      .doc(tournamentId)
      .collection("matches")
      .doc(json["id"])
      .set(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

  @override
  Future<void> updateMatch( Map<String, dynamic> json ) async {
    final base = await _firebaseService.getTournamentBaseUrl();

    final tournamentId = json["tournament_id"];
    json.remove("tournament_id");

    await base
      .doc(tournamentId)
      .collection("matches")
      .doc(json["id"])
      .update(json)
      .onError((error, stackTrace) {
        Session.crash.onError(error.toString(), error: error, stackTrace: stackTrace);
        throw ServerExceptions(error.toString());
      })
      .catchError((onError) {
        Session.crash.log(onError);
        throw ServerExceptions(onError.toString());
      });

    return;
  }

}