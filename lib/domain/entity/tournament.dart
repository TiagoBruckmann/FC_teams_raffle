// import dos domain
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TournamentEntity extends Equatable {

  final String id, name, date, createdAt;
  final bool drawTeams, isActive, hasChampion;
  final int defeats;

  final List<PlayerEntity>? players;

  final List<MatchEntity>? matches;

  const TournamentEntity( this.id, this.name, this.date, this.drawTeams, this.isActive, this.defeats, this.hasChampion, this.createdAt, { this.players, this.matches });

  List<PlayerEntity> get getPlayers => players ?? [];

  List<MatchEntity> get getMatches => matches ?? [];

  bool get getHasChampion => hasChampion;

  factory TournamentEntity.fromMapper( TournamentEntity tournament, List<PlayerEntity> players, List<MatchEntity> matches ) {

    final index = matches.indexWhere((match) => match.player2 == FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.champion"));

    bool hasChampion = true;
    if ( index.isNegative ) {
      hasChampion = false;
    }

    return TournamentEntity(
      tournament.id,
      tournament.name,
      tournament.date,
      tournament.drawTeams,
      ( hasChampion ) ? false : tournament.isActive,
      tournament.defeats,
      hasChampion,
      tournament.createdAt,
      players: players,
      matches: matches,
    );
  }

  bool isEqual( TournamentEntity entity ) {
    final isEqual = id == entity.id && entity.name == name && entity.date == date && entity.createdAt == createdAt;
    return isEqual;
  }

  TournamentEntity updStatus() {
    return TournamentEntity(
      id,
      name,
      date,
      drawTeams,
      !isActive,
      defeats,
      hasChampion,
      createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "date": date,
      "draw_teams": drawTeams,
      "is_active": isActive,
      "defeats": defeats,
      "has_champion": hasChampion,
      "created_at": createdAt,
    };
  }

  @override
  String toString() => "TournamentEntity($name, $date, $defeats, $createdAt, $matches)";

  @override
  List<Object?> get props => [ id, name, date, drawTeams, isActive, defeats, players, matches, hasChampion, createdAt ];

}