// import dos domain
import 'package:fc_teams_drawer/domain/entities/team.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';

class TeamModel extends TeamEntity with EquatableMixin {

  TeamModel( super.name, super.leage, super.logo );

  factory TeamModel.fromJson( Map<String, dynamic> json ) {
    return TeamModel(
      json["name"],
      json["league"],
      json["logo"],
    );
  }

}