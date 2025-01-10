// import dos domain
import 'package:fc_teams_drawer/domain/entity/match.dart';
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/domain/entity/tournament.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: "tournaments_mapper",
  foreignKeys: [
    ForeignKey(
      childColumns: ['tournamentId'],
      parentColumns: ['id'],
      entity: TournamentEntity,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade,
    ),
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
class TournamentMapperEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int tournamentId;
  final int? playerId, matchId;

  const TournamentMapperEntity( this.tournamentId, { this.id, this.playerId, this.matchId });

  factory TournamentMapperEntity.fromPlayerId( int tournamentId, int playerId ) {
    return TournamentMapperEntity(
      tournamentId,
      playerId: playerId,
    );
  }

  factory TournamentMapperEntity.fromMatchId( int tournamentId, int matchId ) {
    return TournamentMapperEntity(
      tournamentId,
      matchId: matchId,
    );
  }

  bool isEqual( TournamentMapperEntity entity ) {
    final isEqual = entity.tournamentId == tournamentId && entity.playerId == playerId && entity.matchId == matchId;
    return isEqual;
  }

  @override
  String toString() => "TournamentMapperEntity($tournamentId, $playerId, $matchId)";

  @override
  List<Object?> get props => [ id, tournamentId, playerId, matchId ];

}