import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

class TournamentModel extends TournamentEntity {
  const TournamentModel(super.name, super.date, super.drawTeams, super.isActive, super.defeats, super.createdAt, { super.id, super.players, super.matches });

  factory TournamentModel.fromQuery( TournamentEntity tournament, List<PlayerEntity> players, List<MatchEntity> matches ) {
    return TournamentModel(
      id: tournament.id,
      tournament.name,
      tournament.date,
      tournament.drawTeams,
      tournament.isActive,
      tournament.defeats,
      tournament.createdAt,
      players: players,
      matches: matches,
    );
  }

}