// import dos pacotes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseService {

  final FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
  final FirebaseDatabase db = FirebaseDatabase.instance;

}