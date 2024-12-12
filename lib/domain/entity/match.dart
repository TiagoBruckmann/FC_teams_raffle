// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "matches")
class MatchEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String player1, logoTeam1, player2, logoTeam2, winner;
  final int round, score1, score2;

  const MatchEntity( this.player1, this.logoTeam1, this.player2, this.logoTeam2, this.winner, this.round, this.score1, this.score2, { this.id });

  void setPlayer1Score( int score ) => score1 + score;

  void setPlayer2Score( int score ) => score2 + score;

  void setPlayer2( String playerName ) => playerName;

  void setWinner() {

    String winner = "";
    if ( score1 > score2 ) {
      winner = player1.replaceAll("_", " ");
      // player1.setWinner(player1);
    } else {
      winner = player2.replaceAll("_", " ");
      // player2.setWinner(player2);
    }

  }

  bool isEqual( MatchEntity match ) {
    return player1 == match.player1 && winner == match.winner;
  }

  @override
  String toString() => "MatchEntity($player1, $score1, $player2, $score2, $round, $winner)";

  @override
  List<Object?> get props => [ id, player1, logoTeam1, player2, logoTeam2, winner, round, score1, score2 ];

}