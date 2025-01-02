// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:fc_teams_drawer/domain/source/local/injection/injection.dart';
import 'package:fc_teams_drawer/domain/usecases/tournament_usecase.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "players")
class PlayerEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name, team;
  final int losses;

  set setLosses( int value ) => losses + 1;
  int get getLosses => losses;

  const PlayerEntity( this.name, this.team, this.losses, { this.id });

  factory PlayerEntity.empty() {
    return const PlayerEntity(
      "Próximo ganhador",
      "",
      0,
    );
  }

  factory PlayerEntity.winner() {
    return const PlayerEntity(
      "Você é o ganhador!",
      "",
      0,
    );
  }

  factory PlayerEntity.fromJson( Map<String, dynamic> json ) {
    return PlayerEntity(
      json["name"] ?? "",
      json["team"] ?? "",
      json["losses"] ?? 0,
    );
  }

  Future<PlayerEntity> setLoser() async {

    print("losses + 1 => ${losses + 1}");
    final player = PlayerEntity(
      name,
      team,
      losses + 1,
    );

    final useCase = TournamentUseCase(getIt());
    final response = await useCase.updatePlayer(player);
    print("setLoser => $response");

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

  @override
  String toString() => "PlayerEntity($name - $team, $losses)";

  @override
  List<Object?> get props => [id, name, team, losses];

}