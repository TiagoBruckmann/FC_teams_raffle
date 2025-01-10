// import dos pacotes
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "fc_teams_drawer")
class FcTeamsDrawerEntity extends Equatable {

  @PrimaryKey()
  final int versionDataSync;

  const FcTeamsDrawerEntity( this.versionDataSync );

  factory FcTeamsDrawerEntity.fromJson( dynamic json ) {

    int versionDataSync = 1;
    if ( json.containsKey("version") ) {
      versionDataSync = json["version"];
    }

    return FcTeamsDrawerEntity(
      versionDataSync,
    );

  }

  @override
  List<Object?> get props => [versionDataSync];

}