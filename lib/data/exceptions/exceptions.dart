class ServerExceptions implements Exception {}

class CacheExceptions implements Exception {
  final String message;
  CacheExceptions( this.message );
}

class GeneralExceptions implements Exception {}
