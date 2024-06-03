// import dos pacotes
import 'package:firebase_performance/firebase_performance.dart';

class Performance {

  final FirebasePerformance _performance = FirebasePerformance.instance;

  HttpMetric newHttpMetric( String url, HttpMethod method ) {
    return _performance.newHttpMetric(url, method);
  }

}