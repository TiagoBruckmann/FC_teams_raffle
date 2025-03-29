import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fc_teams_drawer/data/exceptions/exceptions.dart';
import 'package:fc_teams_drawer/data/model/match_model.dart';
import 'package:fc_teams_drawer/data/model/player_model.dart';
import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:fc_teams_drawer/data/utils/firebase_service.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:injectable/injectable.dart';

abstract class TournamentRemoteDatasource {

  Future<void> createTournament( Map<String, dynamic> json );
  Future<void> updateTournament( Map<String, dynamic> json );
  Future<List<TournamentModel>> getTournaments();
  Future<TournamentEntity?> getTournamentById( String tournamentId );
  Future<void> createOrUpdatePlayers( Map<String, dynamic> json );
  Future<void> createOrUpdateMatches( Map<String, dynamic> json );

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

          for ( final item in value.docs ) {
            tournaments.add(
              TournamentModel.fromJson(item.data()),
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

          final List<MatchModel> tempMatches = List.from(matches);
          tempMatches.sort((a, b) => a.round.compareTo(b.round));
          int lastRound = 0;
          final nextWinner = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_winner");
          final nextLoser = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_loser");

          for ( final match in tempMatches ) {

            if ( lastRound == match.round ) {
              matches.removeWhere((element) => element.round == match.round && ( element.player2 == nextWinner || element.player2 == nextLoser ));
            }
            lastRound = match.round;

          }

          matches.sort((a, b) => b.round.compareTo(a.round));
          tournament = TournamentModel.fromJson(value.data()!, players: players, matches: matches);
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
  Future<void> createOrUpdatePlayers( Map<String, dynamic> json ) async {
    try {
      final base = await _firebaseService.getTournamentBaseUrl();

      final batch = _firebaseService.firestore.batch();

      final tournamentId = json["tournament_id"];

      final playersRef = base.doc(tournamentId).collection("players");

      for ( final player in json["players"] ) {
        final newDoc = playersRef.doc(player["id"]);
        batch.set(newDoc, player, SetOptions(merge: true));
      }

      await batch.commit();
    } catch ( error ) {
      Session.logs.errorLog(error.toString());
      throw ServerExceptions(error.toString());
    }

    return;
  }
  @override
  Future<void> createOrUpdateMatches( Map<String, dynamic> json ) async {
    try {
      final base = await _firebaseService.getTournamentBaseUrl();
      final batch = _firebaseService.firestore.batch();

      final tournamentId = json["tournament_id"];

      final matchesRef = base.doc(tournamentId).collection("matches");

      for ( final match in json["matches"] ) {
        final newDoc = matchesRef.doc(match["id"]);
        batch.set(newDoc, match, SetOptions(merge: true));
      }

      await batch.commit();
    } catch ( error ) {
      Session.logs.errorLog(error.toString());
      throw ServerExceptions(error.toString());
    }

    return;
  }

}