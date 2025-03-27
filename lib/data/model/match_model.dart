import 'package:fc_teams_drawer/domain/entity/match.dart';

class MatchModel extends MatchEntity {
  const MatchModel(super.id, super.player1, super.logoTeam1, super.player2, super.logoTeam2, super.winner, super.round, { super.score1, super.score2 });

  factory MatchModel.fromJson( dynamic json ) {
    return MatchModel(
      json["id"],
      json["player1"],
      json["logo_team1"],
      json["player2"],
      json["logo_team2"],
      json["winner"],
      json["round"],
      score1: json["losses"],
      score2: json["losses"],
    );
  }

}