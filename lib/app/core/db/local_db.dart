import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

class LocalDb {

  Future<Isar> _openDb() async {

    try {

      if (Isar.instanceNames.isEmpty) {

        final dir = await getApplicationDocumentsDirectory();
        final schema = [FCTeamsCollectionSchema];
        return await Isar.open(schema, directory: dir.path);

      }
      return Future.value(Isar.getInstance());

    } catch (ex) {
      SharedServices.logError("Failed to open database");
      throw Exception('Failed to open database: $ex');
    }

  }

  Future<bool> syncFCTeamDataModel( FCTeamsCollection dataModel ) async {
    try {
      SharedServices.logSuccess("Inserting data sync in FCTeams database");

      final response = await _openDb();

      final versionDataSync = await Session.secureStorage.readStorage("version_data_sync") ?? dataModel.versionDataSync;

      final totalDocuments = await response.fCTeamsCollections
          .where()
          .filter()
          .versionDataSyncGreaterThan(versionDataSync)
          .count();

      if ( totalDocuments > 1 ) {
        await _delete(collection: FCTeamsCollection);
      }

      await _insert(object: dataModel);

      SharedServices.logSuccess("Data sync inserted in FCTeams database");
      return true;
    } catch (ex) {
      SharedServices.logError(ex.toString(), message: "No controls were found in the FCTeams database.");
      throw Exception('No controls were found in the FCTeams database. ${ex.toString()}');
    }
  }

  Future<FCTeamsCollection?> getFCTeamCollection( String versionDataSync ) async {
    try {

      final response = await _openDb();

      final dataSync = await response.fCTeamsCollections
          .where()
          .filter()
          .versionDataSyncGreaterThan(versionDataSync)
          .findFirst();

      if ( dataSync == null ) {
        return null;
      }

      SharedServices.logSuccess("Data Sync gotten with success in FCTeamsCollection");

      return dataSync;

    } catch (e, s) {
      SharedServices.logError(e.toString(), message: s.toString());
      throw Exception("${e.toString()} - ${s.toString()}");
    }

  }

  Future<void> _delete<Model>({required collection}) async {
    final isar = await _openDb();

    if ( collection is FCTeamsCollection ) {
      isar.writeTxn(() async => await isar.fCTeamsCollections.clear());
    }

    return;
  }

  Future<bool> _insert<Model>({required object}) async {
    final isar = await _openDb();

    int response = -1;
    if ( object is FCTeamsCollection ) {
      await Session.secureStorage.writeStorage("version_data_sync", object.versionDataSync ?? "0");
      response = await isar.writeTxn(() async => await isar.fCTeamsCollections.put(object));
    }

    if ( response < 0 ) {
      SharedServices.logError("Data Sync inserted with error");
      return false;
    }

    SharedServices.logSuccess("Data Sync inserted with success");
    return true;

  }

}