// import dos domain
import 'package:fc_teams_drawer/domain/entity/key.dart';

class KeyModel extends KeyEntity {

  KeyModel( super.position, super.player1, super.player2, super.player1Scoreboard, super.player2Scoreboard, super.winner );

  factory KeyModel.fromJson( Map<String, dynamic> json ) {

    final hasNotWinner = json["winner"].toString().trim().isEmpty;

    return KeyModel(
      json["position"],
      json["player1"],
      json["player2"],
      hasNotWinner ? null : json["player1_scoreboard"],
      hasNotWinner ? null : json["player2_scoreboard"],
      json["winner"],
    );
  }

}