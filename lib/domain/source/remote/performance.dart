// import dos pacotes
import 'package:fc_teams_drawer/session.dart';
import 'package:firebase_performance/firebase_performance.dart';

class Performance {

  final FirebasePerformance _performance = FirebasePerformance.instance;

  Future<HttpMetric> newHttpMetric( String url, HttpMethod method ) async {
    await Session.appEvents.sharedEventString("http_request_${_httMethodParse(method)}", url);
    return _performance.newHttpMetric(url, method);
  }

  String _httMethodParse( HttpMethod method ) {
    if ( method == HttpMethod.Get ) {
      return "get";
    }

    if ( method == HttpMethod.Put ) {
      return "put";
    }

    if ( method == HttpMethod.Post ) {
      return "post";
    }

    if ( method == HttpMethod.Patch ) {
      return "patch";
    }

    if ( method == HttpMethod.Delete ) {
      return "delete";
    }

    return "another";
  }
}