import 'package:isar/isar.dart';

part 'fc_teams.g.dart';

@collection
class FCTeamsCollection {

  FCTeamsCollection({ this.versionDataSync, this.teamCollection });

  Id id = Isar.autoIncrement;

  int? versionDataSync;
  List<TeamCollection>? teamCollection;

  factory FCTeamsCollection.fromJson( dynamic json ) {

    final List<TeamCollection> teamCollection = [];

    for ( final teams in json["teams"] ) {
      teamCollection.add(
        TeamCollection.fromJson(teams),
      );
    }

    int? versionDataSync;
    if ( json.containsKey("version") ) {
      versionDataSync = json["version"];
    }

    return FCTeamsCollection(
      teamCollection: teamCollection,
      versionDataSync: versionDataSync,
    );

  }

  factory FCTeamsCollection.collectionToEntity( FCTeamsCollection collection ) {

    final List<TeamCollection> teamCollection = [];

    if ( collection.teamCollection != null ) {
      for ( final teams in collection.teamCollection! ) {
        teamCollection.add(
          TeamCollection.collectionToEntity(teams),
        );
      }
    }

    int? versionDataSync;
    if ( collection.versionDataSync != null ) {
      versionDataSync = collection.versionDataSync;
    }

    return FCTeamsCollection(
      teamCollection: teamCollection,
      versionDataSync: versionDataSync,
    );

  }

}

@embedded
class TeamCollection {

  TeamCollection({ this.name, this.league, this.logo, this.score });

  final String? name, league, logo;
  final int? score;

  factory TeamCollection.fromJson( dynamic json ) {
    return TeamCollection(
      name: json["name"],
      league: json["league"],
      logo: json["logo"].toString().toLowerCase(),
      score: json["score"],
    );
  }

  factory TeamCollection.collectionToEntity( TeamCollection? team ) {
    return TeamCollection(
      name: team?.name,
      league: team?.league,
      logo: team?.logo.toString().toLowerCase(),
      score: team?.score,
    );
  }

  bool isNotNull() {
    return name != null && league != null && logo != null && score != null;
  }

  @override
  String toString() => "$name - $league - $score";

}