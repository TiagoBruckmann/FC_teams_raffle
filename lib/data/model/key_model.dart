// import dos domain
import 'package:fc_teams_drawer/domain/entity/key.dart';

// import dos pacotes
import 'package:equatable/equatable.dart';

class KeyModel extends KeyEntity with EquatableMixin {

  KeyModel( super.position, super.player1, super.player2, super.player1Scoreboard, super.player2Scoreboard, super.winner );

  factory KeyModel.fromJson( Map<String, dynamic> json ) {
    return KeyModel(
      json["position"],
      json["player1"],
      json["player2"],
      json["player1_scoreboard"],
      json["player2_scoreboard"],
      json["winner"],
    );
  }

}