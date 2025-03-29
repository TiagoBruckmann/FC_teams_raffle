// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class MatchEntity extends Equatable {

  final String id, player1, logoTeam1, player2, logoTeam2, winner;
  final int round;
  final int? score1, score2;

  const MatchEntity( this.id, this.player1, this.logoTeam1, this.player2, this.logoTeam2, this.winner, this.round, { this.score1, this.score2, });

  MatchEntity setPlayer1Score( int score ) {
    return MatchEntity(
      id,
      player1,
      logoTeam1,
      player2,
      logoTeam2,
      winner,
      round,
      score1: score,
      score2: score2,
    );
  }

  MatchEntity setPlayer2Score( int score ) {
    return MatchEntity(
      id,
      player1,
      logoTeam1,
      player2,
      logoTeam2,
      winner,
      round,
      score1: score1,
      score2: score,
    );
  }

  void setPlayer2( String playerName ) => playerName;

  Future<Map<String, dynamic>> setWinner(  String tournamentId, List<PlayerEntity> players ) async {

    final List<PlayerEntity> allPlayers = List.from(players);

    String matchWinner = player2.replaceAll(" ", "_");
    String loserTeam = logoTeam1;
    if ( score1! > score2! ) {
      matchWinner = player1.replaceAll(" ", "_");
      loserTeam = logoTeam2;
    }

    players.retainWhere((player) => player.team == loserTeam);
    if ( players.isNotEmpty ) {
      final loser = await players.first.setLoser(tournamentId);
      final loserIndex = allPlayers.indexWhere((player) => player.team == loserTeam);

      allPlayers.removeAt(loserIndex);

      allPlayers.insert(loserIndex, loser);
    }

    final match = MatchEntity(
      id,
      player1,
      logoTeam1,
      player2,
      logoTeam2,
      matchWinner,
      round,
      score1: score1,
      score2: score2,
    );

    return {
      "match": match,
      "players": allPlayers,
    };

  }

  bool isEqual( MatchEntity match ) {
    return id == match.id && round == match.round;
  }

  bool hasRound( MatchEntity match ) => round == match.round;

  bool isLoserOrWinner() {
    final nextWinner = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_winner");
    final nextLoser = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_loser");
    return player2 == nextWinner || player2 == nextLoser;
  }

  bool isScoreNotNull() {
    return score1 != null && score2 != null && winner.trim().isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "player1": player1,
      "logo_team1": logoTeam1,
      "score1": score1,
      "player2": player2,
      "logo_team2": logoTeam2,
      "score2": score2,
      "round": round,
      "winner": winner,
    };
  }

  @override
  String toString() => "MatchEntity($id, $player1, $logoTeam1, $score1, $player2, $logoTeam2, $score2, $round, $winner)";

  @override
  List<Object?> get props => [ id, player1, logoTeam1, player2, logoTeam2, winner, round, score1, score2 ];

}