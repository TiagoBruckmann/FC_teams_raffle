import 'package:fc_teams_drawer/data/model/tournament_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class TournamentRemoteDatasource {

  Future<List<TournamentModel>> getTournaments();
  Future<void> updStatus( Map<String, dynamic> json );

}

class TournamentRemoteDatasourceImpl implements TournamentRemoteDatasource {
  final FirebaseDatabase db;
  TournamentRemoteDatasourceImpl( this.db );

  @override
  Future<List<TournamentModel>> getTournaments() async {

    List<TournamentModel> list = [
      TournamentModel("Casa medina", "10/05/2024", true),
      TournamentModel("Casa do andi", "14/06/2024", true),
      TournamentModel("Casa Tchola", "20/04/2024", false),
    ];

    return list;
  }

  @override
  Future<void> updStatus( Map<String, dynamic> json ) async {
    print("updStatus json => $json");
    return;
  }

}