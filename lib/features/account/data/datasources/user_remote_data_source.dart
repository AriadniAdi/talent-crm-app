import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUser(String uid);
  Future<void> updateUser(UserModel user);
}

class FirebaseUserRemoteDataSource implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirebaseUserRemoteDataSource(this._firestore);

  @override
  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toFirestore(), SetOptions(merge: true));
  }
}
