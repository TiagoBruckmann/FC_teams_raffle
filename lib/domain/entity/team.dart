// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "teams")
class TeamEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name, league, logo;
  final int score;

  const TeamEntity( this.name, this.league, this.logo, this.score, { this.id });

  factory TeamEntity.fromJson( dynamic json ) {
    return TeamEntity(
      json["name"],
      json["league"],
      json["logo"].toString().toLowerCase(),
      json["score"],
    );
  }

  bool isEqual( TeamEntity team ) => team.id == id && team.logo == logo;

  @override
  String toString() => "TeamEntity($name - $league - $score)";

  @override
  bool operator ==( Object other ) {
    return other is TeamEntity && other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(name, league, logo, score);

  @override
  List<Object?> get props => [id, name, league, logo, score];

}