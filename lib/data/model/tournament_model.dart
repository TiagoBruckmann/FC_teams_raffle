// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';

class TournamentModel extends TournamentEntity with EquatableMixin {

  TournamentModel( super.name, super.date, super.currentStep, super.quantityGames, super.isActive, super.defeats, super.drawTeams, super.createdAt );

  factory TournamentModel.fromJson( Map<String, dynamic> json ) {
    return TournamentModel(
      json["name"],
      json["date"],
      json["current_step"],
      json["quantity_games"],
      json["is_active"],
      json["defeats"],
      json["draw_teams"],
      json["created_at"],
    );
  }

}