// import dos domain
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

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

  const TournamentEntity( this.name, this.date, this.drawTeams, this.isActive, this.defeats, this.createdAt, { this.id, this.players, this.matches });

  List<PlayerEntity> get getPlayers => players ?? [];

  List<MatchEntity> get getMatches => matches ?? [];

  factory TournamentEntity.fromMapper( TournamentEntity tournament, List<PlayerEntity> players, List<MatchEntity> matches ) {
    return TournamentEntity(
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

  bool isEqual( TournamentEntity entity ) {
    final isEqual = entity.name == name && entity.date == date && entity.createdAt == createdAt;
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
  List<Object?> get props => [ id, name, date, drawTeams, isActive, defeats, players, matches, createdAt ];

}