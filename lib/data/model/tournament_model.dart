// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';

class TournamentModel extends TournamentEntity with EquatableMixin {

  TournamentModel( super.name, super.date, super.isActive, super.createdAt );

  factory TournamentModel.fromJson( Map<String, dynamic> json ) {
    return TournamentModel(
      json["name"],
      json["date"],
      json["is_active"],
      json["created_at"],
    );
  }

}