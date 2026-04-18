import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/core/firebase/firebase_service.dart';

abstract class AuthRemoteDataSource {
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
    required String? phone,
    required String? countryCode,
    required String? cpf,
    required DateTime? birthDate,
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
  final FirebaseService firebaseService;
  final GoogleSignIn googleSignIn;

  FirebaseAuthRemoteDataSource({
    required this.auth,
    required this.firebaseService,
    required this.googleSignIn,
  });

  @override
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
    required String? phone,
    required String? countryCode,
    required String? cpf,
    required DateTime? birthDate,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firebaseService.setData(
        collection: 'users',
        docId: credential.user!.uid,
        data: {
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
          'phone': phone,
          'country_code': countryCode,
          'cpf': cpf,
          'birth_date': birthDate != null ? Timestamp.fromDate(birthDate) : null,
          'data_criacao': FieldValue.serverTimestamp(),
        },
      );

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
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      
      // Em 7.x o accessToken deve ser solicitado via authorizationClient
      final authz = await googleUser.authorizationClient.authorizeScopes([
        'email',
        'openid',
      ]);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authz.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      // Armazena no Firestore se a conta for recém criada (opcional, p/ consistência)
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await firebaseService.setData(
          collection: 'users',
          docId: userCredential.user!.uid,
          data: {
            'name': userCredential.user!.displayName ?? 'Usuário',
            'email': userCredential.user!.email,
            'uid': userCredential.user!.uid,
            'data_criacao': FieldValue.serverTimestamp(),
          },
          merge: true,
        );
      }

      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Failure(
        AuthError(
          e.message,
          AuthErrorCode.authenticationFailed,
        ),
      );
    } catch (e) {
      if (e.toString().contains('canceled')) {
        return Failure(AuthError.withCode(AuthErrorCode.googleSignInCancelled));
      }
      return Failure(UnknownError());
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
