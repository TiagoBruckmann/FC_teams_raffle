// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "teams")
class TeamEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name, league, logo;

  const TeamEntity( this.name, this.league, this.logo, { this.id });

  factory TeamEntity.fromJson( dynamic json ) {
    return TeamEntity(
      json["name"],
      json["league"],
      json["logo"],
    );
  }

  @override
  String toString() => "TeamEntity($name - $league)";

  @override
  List<Object?> get props => [id, name, league, logo];

}