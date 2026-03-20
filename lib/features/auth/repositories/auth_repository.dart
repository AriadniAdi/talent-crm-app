import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _db.collection('users').doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': credential.user!.uid,
        'data_criacao': FieldValue.serverTimestamp(),
      });

      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return Failure(UnknownError());
      return Failure(NetworkError());
    } catch (e) {
      return Failure(UnknownError());
    }
  }

  Future<Result<bool>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return Failure(NotFoundError());
      }
      return Failure(NetworkError());
    } catch (e) {
      return Failure(UnknownError());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
