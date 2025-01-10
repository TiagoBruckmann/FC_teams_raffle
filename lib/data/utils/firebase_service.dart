// import dos pacotes
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseService {

  final FirebaseDatabase db = FirebaseDatabase.instance;

}