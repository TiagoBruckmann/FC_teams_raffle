import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {

  final String name, league, logo;

  const TeamEntity( this.name, this.league, this.logo );

  @override
  List<Object?> get props => [name, league, logo];

  @override
  String toString() => "$name - $league";

}