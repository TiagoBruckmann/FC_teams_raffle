// import dos pacotes
import 'package:fc_teams_drawer/session.dart';
import 'package:firebase_performance/firebase_performance.dart';

class Performance {

  final FirebasePerformance _performance = FirebasePerformance.instance;

  HttpMetric newHttpMetric( String url, HttpMethod method ) {
    Session.appEvents.sharedEventString("http_request_$method", url);
    return _performance.newHttpMetric(url, method);
  }

}