import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRepository {
  static Future<DocumentSnapshot> fetchPeople() async {
    await Firebase.initializeApp();
    return FirebaseFirestore.instance
        .collection('people')
        .doc("100")
        .get();
  }


  static Stream<QuerySnapshot> fetchAllPeople() {
    Firebase.initializeApp();
    return FirebaseFirestore.instance
        .collection('people')
        .limit(100)
        .snapshots();
  }
}
