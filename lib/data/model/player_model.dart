import 'package:fc_teams_drawer/domain/entity/player.dart';

class PlayerModel extends PlayerEntity {
  const PlayerModel(super.id, super.name, super.team, super.losses);

  factory PlayerModel.fromJson( dynamic json ) {
    return PlayerModel(
      json["id"] ?? "",
      json["name"] ?? "",
      json["team"] ?? "",
      json["losses"] ?? 0,
    );
  }

}