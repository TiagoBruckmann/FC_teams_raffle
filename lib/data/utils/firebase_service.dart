// import dos pacotes
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

@injectable
class FirebaseService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseDatabase db = FirebaseDatabase.instance;

  Future<CollectionReference<Map<String, dynamic>>> getTournamentBaseUrl() async {

    final deviceId = await MobileDeviceIdentifier().getDeviceId() ?? "";
    String parsedDeviceId = base64Encode(utf8.encode(deviceId));
    
    return firestore.collection("tournaments").doc(parsedDeviceId).collection(parsedDeviceId);
    
  }
}