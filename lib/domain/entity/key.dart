class KeyEntity {

  String winner;
  final Map<String, dynamic> player1, player2;
  final int position;
  int? player1Scoreboard, player2Scoreboard;

  KeyEntity(
    this.position, this.player1, this.player2, this.player1Scoreboard,
    this.player2Scoreboard, this.winner,
  );

  void setPlayer1Goals(int goals ) => player1Scoreboard = goals;

  void setPlayer2Goals( int goals ) => player2Scoreboard = goals;

  void setWinner() {

    if ( player1Scoreboard == null || player2Scoreboard == null ) {
      return;
    }

    if ( player1Scoreboard! > player2Scoreboard! ) {
      winner = player1["team"].replaceAll("_", " ");
      final qtdDefeats = player2["defeats"];
      player2["defeats"] = qtdDefeats + 1;
    } else {
      winner = player2["team"].replaceAll("_", " ");
      final qtdDefeats = player1["defeats"];
      player1["defeats"] = qtdDefeats + 1;
    }

  }

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

}