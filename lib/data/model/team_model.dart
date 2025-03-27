import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
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

  factory TeamModel.fromFcCollection( TeamCollection team ) {
    return TeamModel(
      team.name!,
      team.league!,
      team.logo!,
      team.score!,
    );
  }

}