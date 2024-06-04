import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageWrapper {

  static const _storage = FlutterSecureStorage();

  Future<void> writeStorage( String key, String content ) async {
    return await _storage.write(key: key, value: content);
  }

  Future<String?> readStorage( String key ) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteStorage( String key ) async {
    return await _storage.delete(key: key);
  }

  Future<void> deleteAllStorage() async {
    return await _storage.deleteAll();
  }

}