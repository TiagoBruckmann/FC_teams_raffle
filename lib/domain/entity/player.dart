// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "players")
class PlayerEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name, team;
  final int losses;

  set setLosses( int value ) => losses + 1;
  int get getLosses => losses;

  const PlayerEntity( this.name, this.team, this.losses, { this.id });

  factory PlayerEntity.empty() {
    return const PlayerEntity(
      "Próximo ganhador",
      "",
      0,
    );
  }

  factory PlayerEntity.fromJson( Map<String, dynamic> json ) {
    return PlayerEntity(
      json["name"] ?? "",
      json["team"] ?? "",
      json["losses"] ?? 0,
    );
  }

  PlayerEntity setLoser() {
    return PlayerEntity(
      name,
      team,
      losses + 1,
    );
  }

  bool isEqual( PlayerEntity entity ) {
    final isEqual = entity.name == name && entity.team == team && entity.losses == losses;
    return isEqual;
  }

  @override
  String toString() => "PlayerEntity($name - $team, $losses)";

  @override
  List<Object?> get props => [id, name, team, losses];

}