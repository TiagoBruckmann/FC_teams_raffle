import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/domain/entity/key.dart';

class TournamentEntity extends Equatable {

  final String name, date, currentStep, createdAt;
  final int defeats, quantityGames, quantityPlayers;
  final bool isActive, drawTeams;
  final List<KeyEntity> listKeys;

  const TournamentEntity( this.name, this.date, this.currentStep, this.quantityGames, this.quantityPlayers, this.isActive, this.defeats, this.drawTeams, this.createdAt, this.listKeys );

  factory TournamentEntity.fromJson( Map<String, dynamic> json, List<KeyEntity> listKeys ) {
    return TournamentEntity(
      json["name"],
      json["date"],
      json["current_step"],
      json["quantity_games"],
      json["quantity_players"],
      json["is_active"],
      json["defeats"],
      json["draw_teams"],
      json["created_at"],
      listKeys,
    );
  }

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "name": name,
      "date": date,
      "current_step": currentStep,
      "quantity_games": quantityGames,
      "quantity_players": quantityPlayers,
      "is_active": isActive,
      "defeats": defeats,
      "draw_teams": drawTeams,
      "created_at": createdAt,
      "list_keys": listKeys,
    };

    return map;
  }

  Map<String, dynamic> customMap() {

    Map<String, dynamic> map = {
      "step": currentStep,
      "created_at": createdAt,
    };

    return map;
  }

  Map<String, dynamic> updStatus( bool status ) {

    Map<String, dynamic> map = {
      "name": name,
      "date": date,
      "is_active": status,
      "created_at": createdAt,
    };

    return map;
  }

  Map<String, dynamic> updStep( String step, int qtdGames ) {

    Map<String, dynamic> map = {
      "current_step": step,
      "quantity_games": qtdGames,
      "created_at": createdAt,
    };

    return map;
  }

  @override
  List<Object?> get props => [name, date, currentStep, quantityGames, quantityPlayers, isActive, defeats, drawTeams, createdAt, listKeys];

}