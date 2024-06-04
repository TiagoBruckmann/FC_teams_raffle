import 'package:isar/isar.dart';

part 'fc_teams.g.dart';

@collection
class FCTeamsCollection {

  FCTeamsCollection({ this.versionDataSync, this.teamCollection });

  Id id = Isar.autoIncrement;

  String? versionDataSync;
  List<TeamCollection>? teamCollection;

  factory FCTeamsCollection.fromJson( Map<String, dynamic> json ) {

    final List<TeamCollection> teamCollection = [];

    for ( final teams in json["teams"] ) {
      teamCollection.add(
        TeamCollection.fromJson(teams),
      );
    }

    String? versionDataSync;
    if ( json.containsKey("config") ) {
      versionDataSync = json["config"]["version"];
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

    String? versionDataSync;
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

  TeamCollection({ this.name, this.league, this.logo });

  final String? name, league, logo;

  factory TeamCollection.fromJson( Map<String, dynamic> json ) {
    return TeamCollection(
      name: json["name"],
      league: json["league"],
      logo: json["logo"],
    );
  }

  factory TeamCollection.collectionToEntity( TeamCollection? team ) {
    return TeamCollection(
      name: team?.name,
      league: team?.league,
      logo: team?.logo,
    );
  }

}