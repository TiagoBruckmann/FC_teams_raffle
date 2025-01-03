// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "matches")
class MatchEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String player1, logoTeam1, player2, logoTeam2, winner;
  final int round;
  final int? score1, score2;

  const MatchEntity( this.player1, this.logoTeam1, this.player2, this.logoTeam2, this.winner, this.round, { this.id, this.score1, this.score2, });

  MatchEntity setPlayer1Score( int score ) {
    return MatchEntity(
      id: id,
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
      id: id,
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

  Future<Map<String, dynamic>> setWinner( List<PlayerEntity> players ) async {

    final List<PlayerEntity> allPlayers = List.from(players);

    String matchWinner = player2.replaceAll(" ", "_");
    String loserTeam = logoTeam1;
    if ( score1! > score2! ) {
      matchWinner = player1.replaceAll(" ", "_");
      loserTeam = logoTeam2;
    }

    players.retainWhere((player) => player.team == loserTeam);
    if ( players.isNotEmpty ) {
      final loser = await players.first.setLoser();
      final loserIndex = allPlayers.indexWhere((player) => player.team == loserTeam);

      allPlayers.removeAt(loserIndex);

      allPlayers.insert(loserIndex, loser);
    }

    final match = MatchEntity(
      id: id,
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

  @override
  String toString() => "MatchEntity($player1, $score1, $player2, $score2, $round, $winner)";

  @override
  List<Object?> get props => [ id, player1, logoTeam1, player2, logoTeam2, winner, round, score1, score2 ];

}