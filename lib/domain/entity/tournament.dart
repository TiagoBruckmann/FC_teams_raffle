// import dos domain
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: "tournaments",
  foreignKeys: [
    ForeignKey(
      childColumns: ['playerId'],
      parentColumns: ['id'],
      entity: PlayerEntity,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['matchId'],
      parentColumns: ['id'],
      entity: MatchEntity,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade,
    ),
  ],
)
class TournamentEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final List<String> playerId, matchId;
  final String name, date, createdAt;
  final bool drawTeams, isActive;
  final int defeats;

  List<int> get getPlayersId {
    final List<int> playersIds = [];

    for ( final id in playerId ) {
      playersIds.add(int.parse(id));
    }

    return playersIds;
  }

  List<int> get getMatchesIds {
    final List<int> matchesIds = [];

    for ( final id in matchId ) {
      matchesIds.add(int.parse(id));
    }

    return matchesIds;
  }

  const TournamentEntity( this.name, this.date, this.playerId, this.matchId, this.drawTeams, this.isActive, this.defeats, this.createdAt, { this.id });

  bool isEqual( TournamentEntity entity ) {
    final isEqual = entity.name == name && entity.date == date && entity.createdAt == createdAt;
    return isEqual;
  }

  TournamentEntity updStatus() {
    return TournamentEntity(
      name,
      date,
      playerId,
      matchId,
      drawTeams,
      !isActive,
      defeats,
      createdAt,
    );
  }

  @override
  String toString() => "TournamentEntity($name, $date, $defeats, $createdAt, ${playerId.toList()}, ${matchId.toList()})";

  @override
  List<Object?> get props => [id, name, date, playerId, matchId, drawTeams, isActive, defeats, createdAt ];

}