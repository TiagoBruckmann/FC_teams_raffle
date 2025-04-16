import 'package:fc_teams_drawer/domain/entity/team.dart';

class TeamModel extends TeamEntity {
  const TeamModel(super.name, super.league, super.logo, super.score);

  factory TeamModel.fromJson( dynamic json ) {
    return TeamModel(
      json["name"],
      json["league"],
      json["logo"].toString().toLowerCase(),
      json["score"],
    );
  }

}