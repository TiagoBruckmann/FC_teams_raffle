// import dos domain
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:floor/floor.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

@Entity(tableName: "tournaments")
class TournamentEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name, date, createdAt;
  final bool drawTeams, isActive;
  final int defeats;

  @ignore
  final List<PlayerEntity>? players;

  @ignore
  final List<MatchEntity>? matches;

  @ignore
  final bool? hasChampion;

  const TournamentEntity( this.name, this.date, this.drawTeams, this.isActive, this.defeats, this.createdAt, { this.id, this.players, this.matches, this.hasChampion });

  List<PlayerEntity> get getPlayers => players ?? [];

  List<MatchEntity> get getMatches => matches ?? [];

  bool get getHasChampion => hasChampion ?? false;

  factory TournamentEntity.fromMapper( TournamentEntity tournament, List<PlayerEntity> players, List<MatchEntity> matches ) {

    final index = matches.indexWhere((match) => match.player2 == FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.champion"));

    bool hasChampion = true;
    if ( index.isNegative ) {
      hasChampion = false;
    }

    return TournamentEntity(
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

  bool isEqual( TournamentEntity entity ) {
    final isEqual = id == entity.id && entity.name == name && entity.date == date && entity.createdAt == createdAt;
    return isEqual;
  }

  TournamentEntity setTournamentId( int tournamentId ) {
    return TournamentEntity(
      id: tournamentId,
      name,
      date,
      drawTeams,
      !isActive,
      defeats,
      createdAt,
    );
  }

  TournamentEntity updStatus() {
    return TournamentEntity(
      id: id,
      name,
      date,
      drawTeams,
      !isActive,
      defeats,
      createdAt,
    );
  }

  @override
  String toString() => "TournamentEntity($name, $date, $defeats, $createdAt, $matches)";

  @override
  List<Object?> get props => [ id, name, date, drawTeams, isActive, defeats, players, matches, hasChampion, createdAt ];

}