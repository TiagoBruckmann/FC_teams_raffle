// import dos pacotes
import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {

  final String name, league, logo;
  final int score;

  const TeamEntity( this.name, this.league, this.logo, this.score );

  bool isEqual( TeamEntity team ) => team.league == league && team.logo == logo;

  @override
  String toString() => "TeamEntity($name - $league - $score)";

  @override
  bool operator ==( Object other ) {
    return other is TeamEntity && other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(name, league, logo, score);

  @override
  List<Object?> get props => [name, league, logo, score];

}