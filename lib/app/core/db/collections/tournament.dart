import 'package:isar/isar.dart';

part 'tournament.g.dart';

@collection
class GamesCollection {

  GamesCollection({ this.listTournaments });

  Id id = Isar.autoIncrement;

  List<TournamentCollection>? listTournaments;

  factory GamesCollection.fromJson( dynamic json ) {

    List<KeyCollection> listKeys = [];

    List<TournamentCollection> tournaments = [];
    for ( final key in json["keys"]["keys"] ) {
      if ( key != null ) {
        listKeys.add(
          KeyCollection.fromJson(key),
        );
      }
    }

    if ( json["tournaments"] != null ) {
      tournaments.add(
        TournamentCollection.fromJson(json["tournaments"], listKeys),
      );
    }

    return GamesCollection(
      listTournaments: tournaments,
    );

  }

  factory GamesCollection.collectionToEntity( GamesCollection collection ) {

    final List<TournamentCollection> tournamentCollection = [];

    if ( collection.listTournaments != null ) {
      for ( final tournament in collection.listTournaments! ) {
        tournamentCollection.add(
          TournamentCollection.collectionToEntity(tournament),
        );
      }
    }

    return GamesCollection(
      listTournaments: tournamentCollection,
    );

  }

}

@embedded
class TournamentCollection {

  final String? name, date, currentStep, createdAt;
  final int? defeats, quantityPlayers, quantityGames;
  final bool? drawTeams;
  final List<KeyCollection>? listKeys;
  bool? isActive;

  TournamentCollection({
    this.name, this.date, this.currentStep, this.quantityPlayers, this.quantityGames,
    this.isActive, this.defeats, this.drawTeams, this.createdAt, this.listKeys,
  });

  factory TournamentCollection.fromJson( Map<String, dynamic> json, List<KeyCollection> listKeys ) {
    return TournamentCollection(
      name: json["name"],
      date: json["date"],
      currentStep: json["current_step"],
      quantityPlayers: json["quantity_players"],
      quantityGames: json["quantity_games"],
      isActive: json["is_active"],
      defeats: json["defeats"],
      drawTeams: json["draw_teams"],
      createdAt: json["created_at"],
      listKeys: listKeys,
    );
  }

  factory TournamentCollection.collectionToEntity( TournamentCollection collection ) {
    return TournamentCollection(
      name: collection.name,
      date: collection.date,
      currentStep: collection.currentStep,
      quantityPlayers: collection.quantityPlayers,
      quantityGames: collection.quantityGames,
      isActive: collection.isActive,
      defeats: collection.defeats,
      drawTeams: collection.drawTeams,
      createdAt: collection.createdAt,
      listKeys: collection.listKeys,
    );
  }

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "name": name,
      "date": date,
      "current_step": currentStep,
      "quantity_players": quantityPlayers,
      "quantity_games": quantityGames,
      "is_active": isActive,
      "defeats": defeats,
      "draw_teams": drawTeams,
      "created_at": createdAt,
      "list_keys": listKeys,
    };

    return map;
  }

  void updStatus() {
    isActive = !isActive!;
    return;
  }

  Map<String, dynamic> updStep( String step, int qtdGames ) {

    Map<String, dynamic> map = {
      "current_step": step,
      "quantity_games": qtdGames,
      "created_at": createdAt,
    };

    return map;
  }

  bool isEqual( TournamentCollection collection ) {
    return name == collection.name && quantityPlayers == collection.quantityPlayers && createdAt == collection.createdAt;
  }

}

@embedded
class KeyCollection {

  String? winner;
  final PlayerCollection? player1;
  PlayerCollection? player2;
  final int? position;
  int? player1Scoreboard, player2Scoreboard;

  KeyCollection({
    this.position, this.player1, this.player2, this.player1Scoreboard,
    this.player2Scoreboard, this.winner,
  });

  factory KeyCollection.fromJson( Map<String, dynamic> json ) {

    final hasNotWinner = json["winner"].toString().trim().isEmpty;

    return KeyCollection(
      position: json["position"] ?? 0,
      player1: json["player1"],
      player2: json["player2"],
      player1Scoreboard: hasNotWinner ? null : json["player1_scoreboard"],
      player2Scoreboard: hasNotWinner ? null : json["player2_scoreboard"],
      winner: json["winner"] ?? "",
    );
  }

  void setPlayer1Goals(int goals ) => player1Scoreboard = goals;

  void setPlayer2Goals( int goals ) => player2Scoreboard = goals;

  void setPlayer2( PlayerCollection player ) => player2 = player;

  void setWinner() {

    if ( player1Scoreboard == null || player2Scoreboard == null ) {
      return;
    }

    if ( player1Scoreboard! > player2Scoreboard! ) {
      winner = player1!.team!.replaceAll("_", " ");
      player1!.setWinner(player1!);
    } else {
      winner = player2!.team!.replaceAll("_", " ");
      player2!.setWinner(player1!);
    }

  }

  Map<String, dynamic> toMap( Map<String, dynamic> json ) {

    json.addAll({
      "position": position,
      "player1": player1,
      "player2": player2,
      "player1_scoreboard": player1Scoreboard,
      "player2_scoreboard": player2Scoreboard,
      "winner": winner,
    });

    return json;
  }

  Map<String, dynamic> updScoreBoard( int player1Goals, int player2Goals ) {

    String winner = player1!.team!;
    if ( player2Goals > player1Goals ) {
      winner = player2!.team!;
    }

    Map<String, dynamic> map = {
      "position": position,
      "player1_scoreboard": player1Goals,
      "player2_scoreboard": player2Goals,
      "winner": winner,
    };

    return map;
  }

  bool isEqual( KeyCollection key ) {
    return position == key.position && player1 == key.player1 && winner == key.winner;
  }

  @override
  String toString() => "KeyCollection($player1, $player1Scoreboard, $player2, $player2Scoreboard, $position, $winner)";

}

@embedded
class PlayerCollection {

  final String? name, team;
  int? defeats;

  PlayerCollection({
    this.name, this.team, this.defeats,
  });

  factory PlayerCollection.empty() {
    return PlayerCollection(
      name: "",
      team: "",
      defeats: 0,
    );
  }

  factory PlayerCollection.fromJson( Map<String, dynamic> json ) {
    return PlayerCollection(
      name: json["name"] ?? "",
      team: json["team"] ?? "",
      defeats: json["defeats"] ?? 0,
    );
  }

  void setWinner( PlayerCollection loser ) {

    if ( name!.contains(loser.name!) && team!.contains(loser.team!) ) {
      updDefeats();
    }

  }

  void updDefeats() {
    defeats ??= 1;
    if ( defeats != null ) {
      defeats! + 1;
    }
  }

  bool isEqual( PlayerCollection entity ) {
    final isEqual = entity.name == name && entity.team == team && entity.defeats == defeats;
    return isEqual;
  }

  Map<String, dynamic> toMap( Map<String, dynamic> json ) {

    json.addAll({
      "name": name,
      "team": team,
      "defeats": defeats,
    });

    return json;
  }

  @override
  String toString() => "PlayerCollection($name, $team, $defeats)";

}