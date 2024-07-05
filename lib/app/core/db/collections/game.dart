import 'package:isar/isar.dart';

part 'game.g.dart';

@Collection()
class PlayerCollection {

  PlayerCollection( this.name, this.team, this.losses );

  Id id = Isar.autoIncrement;

  late String name, team;
  int losses = 0;

  factory PlayerCollection.empty() {
    return PlayerCollection(
      "Próximo ganhador",
      "",
      0,
    );
  }

  factory PlayerCollection.fromJson( Map<String, dynamic> json ) {
    return PlayerCollection(
      json["name"] ?? "",
      json["team"] ?? "",
      json["losses"] ?? 0,
    );
  }

  void setWinner( PlayerCollection loser ) {

    if ( name.contains(loser.name) && team.contains(loser.team) ) {
      updDefeats();
    }

  }

  void updDefeats() => losses++;

  bool isEqual( PlayerCollection entity ) {
    final isEqual = entity.name == name && entity.team == team && entity.losses == losses;
    return isEqual;
  }

  @override
  String toString() => "PlayerCollection($name, $team, $losses)";

}

@Collection()
class TournamentCollection {

  TournamentCollection( this.name, this.date, this.defeats, this.isActive, this.drawTeams, this.createdAt );

  Id id = Isar.autoIncrement;

  late String name, date, createdAt;
  late bool drawTeams, isActive;
  late int defeats;
  final players = IsarLinks<PlayerCollection>();
  final matches = IsarLinks<MatchCollection>();

  void updStatus() => isActive = !isActive;

  bool isEqual( TournamentCollection collection ) {
    return name == collection.name && createdAt == collection.createdAt;
  }

  @override
  String toString() => "TournamentCollection($name, $date, $defeats, $createdAt, ${players.toList()}, ${matches.toList()})";

}

@Collection()
class MatchCollection {

  MatchCollection( this.player1, this.player2, this.score1, this.score2, this.round, this.winner );

  Id id = Isar.autoIncrement;

  late String player1, player2;
  late int? score1, score2;
  late String winner;
  late int round;

  void setPlayer1Goals(int goals ) => score1 = goals;

  void setPlayer2Goals( int goals ) => score2 = goals;

  void setPlayer2( PlayerCollection player ) => player2 = player.toString();

  void setWinner() {

    if ( score1 == null || score2 == null ) {
      return;
    }

    /*
    if ( score1! > score2! ) {
      winner = player1.team.replaceAll("_", " ");
      player1.setWinner(player1);
    } else {
      winner = player2.team.replaceAll("_", " ");
      player2.setWinner(player2);
    }
     */

  }

  bool isEqual( MatchCollection match ) {
    return player1 == match.player1 && winner == match.winner;
  }

  @override
  String toString() => "MatchCollection($player1, $score1, $player2, $score2, $round, $winner)";

}