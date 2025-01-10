import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TournamentModel extends TournamentEntity {
  const TournamentModel(super.name, super.date, super.drawTeams, super.isActive, super.defeats, super.createdAt, { super.id, super.players, super.matches, super.hasChampion });

  factory TournamentModel.fromQuery( TournamentEntity tournament, List<PlayerEntity> players, List<MatchEntity> matches ) {

    final index = matches.indexWhere((match) => match.player2 == FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.champion"));

    bool hasChampion = true;
    if ( index.isNegative ) {
      hasChampion = false;
    }

    return TournamentModel(
      id: tournament.id,
      tournament.name,
      tournament.date,
      tournament.drawTeams,
      ( hasChampion ) ? false : tournament.isActive,
      tournament.defeats,
      tournament.createdAt,
      players: players,
      matches: matches,
      hasChampion: hasChampion,
    );
  }

}