// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class PlayerEntity extends Equatable {

  final String id, name, team;
  final int losses;

  set setLosses( int value ) => losses + 1;
  int get getLosses => losses;

  const PlayerEntity( this.id, this.name, this.team, this.losses );

  factory PlayerEntity.nextWinner( String id ) {
    return PlayerEntity(
      id,
      FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_winner"),
      "",
      0,
    );
  }

  factory PlayerEntity.nextLoser( String id ) {
    return PlayerEntity(
      id,
      FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_loser"),
      "",
      0,
    );
  }

  factory PlayerEntity.champion( String id ) {
    return PlayerEntity(
      id,
      FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.champion"),
      "",
      0,
    );
  }

  Future<PlayerEntity> setLoser( String tournamentId ) async {
    final player = PlayerEntity(
      id,
      name,
      team,
      losses + 1,
    );

    final useCase = TournamentUseCase(getIt());
    final response = await useCase.updatePlayer(tournamentId, player);

    response.fold(
      (failure) => Session.logs.errorLog(failure.message),
      (success) => success,
    );

    return player;
  }

  bool isEqual( PlayerEntity entity ) {
    final isEqual = entity.name == name && entity.team == team && entity.losses == losses;
    return isEqual;
  }

  bool isEqualPlayerMatch( String playerName, String teamLogo ) {
    final isEqual = playerName == name && teamLogo == team;
    return isEqual;
  }

  Map<String, dynamic> toJson( Map<String, dynamic> json ) {
    json.addAll({
      "id": id,
      "name": name,
      "team": team,
      "losses": losses,
    });

    return json;
  }

  @override
  String toString() => "PlayerEntity($name - $team, $losses)";

  @override
  List<Object?> get props => [id, name, team, losses];

}