// import dos domain
import 'package:fc_teams_drawer/domain/entity/player.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';

class PlayerModel extends PlayerEntity with EquatableMixin {

  PlayerModel( super.name, super.team, super.defeats, );

  factory PlayerModel.fromJson( Map<String, dynamic> json ) {
    return PlayerModel(
      json["name"],
      json["team"],
      json["defeats"],
    );
  }

}