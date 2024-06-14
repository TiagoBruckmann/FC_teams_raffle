import 'package:equatable/equatable.dart';

class TournamentEntity extends Equatable {

  final String name, date, currentStep, createdAt;
  final int defeats, quantityGames;
  final bool isActive, drawTeams;

  const TournamentEntity( this.name, this.date, this.currentStep, this.quantityGames, this.isActive, this.defeats, this.drawTeams, this.createdAt );

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "name": name,
      "date": date,
      "current_step": currentStep,
      "quantity_games": quantityGames,
      "is_active": isActive,
      "defeats": defeats,
      "draw_teams": drawTeams,
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
  List<Object?> get props => [name, date, currentStep, isActive, defeats, drawTeams, createdAt];

}