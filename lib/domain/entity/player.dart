import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {

  final String name, team;
  final int defeats;

  const PlayerEntity( this.name, this.team, this.defeats );

  factory PlayerEntity.fromJson( Map<String, dynamic> json ) {
    return PlayerEntity(
      json["name"],
      json["team"],
      json["defeats"],
    );
  }

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "name": name,
      "team": team,
      "defeats": defeats,
    };

    return map;
  }

  Map<String, dynamic> updDefeats( int defeat ) {

    Map<String, dynamic> map = {
      "name": name,
      "defeats": defeat,
    };

    return map;
  }

  bool isEqual( PlayerEntity entity ) {
    final isEqual = entity.name == name && entity.team == team && entity.defeats == defeats;
    return isEqual;
  }

  @override
  List<Object?> get props => [name, team, defeats];

}