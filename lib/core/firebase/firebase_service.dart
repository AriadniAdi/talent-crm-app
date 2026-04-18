import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseService {
  Future<void> setData({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = false,
  });
}

class FirebaseFirestoreService implements FirebaseService {
  final FirebaseFirestore _db;

  FirebaseFirestoreService(this._db);

  @override
  Future<void> setData({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    await _db.collection(collection).doc(docId).set(data, SetOptions(merge: merge));
  }
}
