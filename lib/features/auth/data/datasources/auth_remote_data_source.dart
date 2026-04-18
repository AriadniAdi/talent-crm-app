import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<Result<bool>> signInWithGoogle();

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
        return Failure(AuthError.withCode(AuthErrorCode.emailAlreadyInUse));
      }

      if (e.code == 'invalid-email') {
        return Failure(AuthError.withCode(AuthErrorCode.invalidEmail));
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
        return Failure(AuthError.withCode(AuthErrorCode.invalidCredentials));
      }

      return Failure(NetworkError());
    } catch (_) {
      return Failure(UnknownError());
    }
  }

  @override
  Future<Result<bool>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Failure(AuthError.withCode(AuthErrorCode.googleSignInCancelled));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      // Armazena no Firestore se a conta for recém criada (opcional, p/ consistência)
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await db.collection('users').doc(userCredential.user!.uid).set({
          'name': userCredential.user!.displayName ?? 'Usuário',
          'email': userCredential.user!.email,
          'uid': userCredential.user!.uid,
          'data_criacao': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Failure(
        AuthError(
          e.message,
          AuthErrorCode.authenticationFailed,
        ),
      );
    } catch (_) {
      return Failure(UnknownError());
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
