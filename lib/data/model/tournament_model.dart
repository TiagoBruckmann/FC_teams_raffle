import 'package:fc_teams_drawer/data/model/match_model.dart';
import 'package:fc_teams_drawer/data/model/player_model.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TournamentModel extends TournamentEntity {
  const TournamentModel( super.id, super.name, super.date, super.drawTeams, super.isActive, super.defeats, super.hasChampion, super.createdAt, { super.players, super.matches });

  factory TournamentModel.fromJson( Map<String, dynamic> json, List<PlayerModel> players, List<MatchModel> matches ) {

    final index = matches.indexWhere((match) => match.player2 == FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.champion"));

    bool hasChampion = true;
    if ( index.isNegative ) {
      hasChampion = false;
    }

    return TournamentModel(
      json["id"],
      json["name"],
      json["date"],
      json["draw_teams"],
      ( hasChampion ) ? false : json["is_active"],
      json["defeats"],
      hasChampion,
      json["created_at"],
      players: players,
      matches: matches,
    );
  }

}