import 'package:equatable/equatable.dart';

class KeyEntity extends Equatable {

  final String winner;
  final Map<String, dynamic> player1, player2;
  final int position, player1Scoreboard, player2Scoreboard;

  const KeyEntity(
    this.position, this.player1, this.player2, this.player1Scoreboard,
    this.player2Scoreboard, this.winner,
  );

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "position": position,
      "player1": player1,
      "player2": player2,
      "player1_scoreboard": player1Scoreboard,
      "player2_scoreboard": player2Scoreboard,
      "winner": winner,
    };

    return map;
  }

  Map<String, dynamic> updateMug( Map<String, dynamic> secondPlayer ) {

    Map<String, dynamic> map = {
      "position": position,
      "player2": secondPlayer,
    };

    return map;
  }

  Map<String, dynamic> updScoreBoard( int player1Goals, int player2Goals ) {

    String winner = player1["team"];
    if ( player2Goals > player1Goals ) {
      winner = player2["team"];
    }

    Map<String, dynamic> map = {
      "position": position,
      "player1_scoreboard": player1Goals,
      "player2_scoreboard": player2Goals,
      "winner": winner,
    };

    return map;
  }

  @override
  List<Object?> get props => [position, player1, player2, player1Scoreboard, player2Scoreboard, winner];

}