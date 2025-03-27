import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

@injectable
class LocalDb {

  Future<Isar> _openDb() async {

    try {

      if ( Isar.instanceNames.isEmpty ) {

        final dir = await getApplicationDocumentsDirectory();
        final schema = [FCTeamsCollectionSchema];
        return await Isar.open(schema, directory: dir.path);

      }
      return Future.value(Isar.getInstance());

    } catch (ex) {
      Session.logs.errorLog("Failed to open database");
      throw Exception('Failed to open database: $ex');
    }

  }

  Future<bool> syncFCTeamDataModel( FCTeamsCollection dataModel ) async {
    try {
      Session.logs.successLog("Inserting data sync in FCTeams database");

      final response = await _openDb();

      final totalDocuments = await response.fCTeamsCollections
          .where()
          .filter()
          .versionDataSyncEqualTo(dataModel.versionDataSync)
          .count();

      if ( totalDocuments > 1 ) {
        await _delete(collection: FCTeamsCollection);
      }

      await _insert(object: dataModel);

      Session.logs.successLog("Data sync inserted in FCTeams database");
      return true;
    } catch (ex) {
      Session.logs.errorLog("No controls were found in the FCTeams database. - ${ex.toString()}");
      throw Exception('No controls were found in the FCTeams database. ${ex.toString()}');
    }
  }

  Future<FCTeamsCollection?> getFCTeamCollection( int versionDataSync ) async {
    try {

      final response = await _openDb();

      final dataSync = await response.fCTeamsCollections
          .where()
          .filter()
          .versionDataSyncEqualTo(versionDataSync)
          .findFirst();

      if ( dataSync == null ) {
        return null;
      }

      Session.logs.successLog("Data Sync gotten with success in FCTeamsCollection");

      return dataSync;

    } catch (e, s) {
      Session.logs.errorLog(e.toString());
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

      await Session.secureStorage.writeStorage("version_data_sync", object.versionDataSync.toString());
      response = await isar.writeTxn(() async => await isar.fCTeamsCollections.put(object));
    }

    if ( response < 0 ) {
      Session.logs.errorLog("Data Sync inserted with error");
      return false;
    }

    Session.logs.successLog("Data Sync inserted with success");
    return true;

  }

}