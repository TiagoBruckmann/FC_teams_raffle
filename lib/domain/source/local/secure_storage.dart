import 'package:fc_teams_drawer/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageWrapper {

  static const _storage = FlutterSecureStorage();

  Future<void> writeStorage( String key, String content ) async {
    Session.appEvents.sharedEvent("set_credential_$key");
    return await _storage.write(key: key, value: content);
  }

  Future<String?> readStorage( String key ) async {
    Session.appEvents.sharedEvent("get_credential_$key");
    return await _storage.read(key: key);
  }

  Future<void> deleteStorage( String key ) async {
    Session.appEvents.sharedEvent("delete_credential_$key");
    return await _storage.delete(key: key);
  }

  Future<void> deleteAllStorage() async {
    Session.appEvents.sharedEvent("delete_all_credentials");
    return await _storage.deleteAll();
  }

}