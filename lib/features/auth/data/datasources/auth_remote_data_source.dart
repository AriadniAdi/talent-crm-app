import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';

abstract class AuthRemoteDataSource {
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Result<bool>> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  const FirebaseAuthRemoteDataSource({
    required this.auth,
    required this.db,
  });

  @override
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await db.collection('users').doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': credential.user!.uid,
        'data_criacao': FieldValue.serverTimestamp(),
      });

      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Failure(AuthError('E-mail já cadastrado'));
      }

      if (e.code == 'invalid-email') {
        return Failure(AuthError('E-mail inválido'));
      }

      return Failure(NetworkError());
    } catch (_) {
      return Failure(UnknownError());
    }
  }

  @override
  Future<Result<bool>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return Failure(NotFoundError());
      }

      return Failure(NetworkError());
    } catch (_) {
      return Failure(UnknownError());
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
