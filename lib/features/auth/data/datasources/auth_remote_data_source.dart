import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talent_crm_app/core/auth/facebook_auth_service.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/firebase/firebase_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

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

  Future<Result<bool>> signInWithApple();

  Future<Result<bool>> signInWithFacebook();

  Future<void> signOut();
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseService firebaseService;
  final GoogleSignIn googleSignIn;
  final FacebookAuthService facebookAuthService;
  final bool useNativeFacebookSignIn;

  FirebaseAuthRemoteDataSource({
    required this.auth,
    required this.firebaseService,
    required this.googleSignIn,
    required this.facebookAuthService,
    bool? useNativeFacebookSignIn,
  }) : useNativeFacebookSignIn = useNativeFacebookSignIn ?? !kIsWeb;

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

      final userModel = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        countryCode: countryCode,
        cpf: cpf,
        birthDate: birthDate,
      );

      await firebaseService.setData(
        collection: 'users',
        docId: userModel.uid,
        data: userModel.toFirestore(),
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

      if (googleAuth.idToken == null || googleAuth.idToken!.isEmpty) {
        return Failure(
          AuthError(
            'Nao foi possivel obter as credenciais do Google para continuar.',
            AuthErrorCode.authenticationFailed,
          ),
        );
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authz.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      await _persistSocialUser(userCredential);

      return Success(true);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return Failure(AuthError.withCode(AuthErrorCode.googleSignInCancelled));
      }

      return Failure(
        AuthError(
          e.description,
          AuthErrorCode.authenticationFailed,
        ),
      );
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
  Future<Result<bool>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');
      final userCredential = await auth.signInWithProvider(appleProvider);
      await _persistSocialUser(userCredential, fallbackName: 'Usuario Apple');

      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (_isSignInCancelled(e)) {
        return Failure(AuthError.withCode(AuthErrorCode.appleSignInCancelled));
      }

      return Failure(
        AuthError(
          e.message,
          AuthErrorCode.authenticationFailed,
        ),
      );
    } catch (e) {
      if (_looksCancelled(e)) {
        return Failure(AuthError.withCode(AuthErrorCode.appleSignInCancelled));
      }

      return Failure(UnknownError());
    }
  }

  @override
  Future<Result<bool>> signInWithFacebook() async {
    if (!useNativeFacebookSignIn) {
      return _signInWithFacebookProvider();
    }

    return _signInWithFacebookNative();
  }

  Future<Result<bool>> _signInWithFacebookNative() async {
    try {
      final loginResult = await facebookAuthService.login();

      switch (loginResult.status) {
        case FacebookLoginStatus.cancelled:
          return Failure(
            AuthError.withCode(AuthErrorCode.facebookSignInCancelled),
          );
        case FacebookLoginStatus.failed:
        case FacebookLoginStatus.operationInProgress:
          return Failure(
            AuthError(
              loginResult.message ??
                  'Nao foi possivel iniciar o Facebook Login.',
              AuthErrorCode.authenticationFailed,
            ),
          );
        case FacebookLoginStatus.success:
          break;
      }

      final accessToken = loginResult.accessToken;
      if (accessToken == null || accessToken.isEmpty) {
        return Failure(
          AuthError(
            'Nao foi possivel obter as credenciais do Facebook para continuar.',
            AuthErrorCode.authenticationFailed,
          ),
        );
      }

      final credential = FacebookAuthProvider.credential(accessToken);
      final userCredential = await auth.signInWithCredential(credential);
      await _persistSocialUser(
        userCredential,
        fallbackName: 'Usuario Facebook',
      );

      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (_isSignInCancelled(e)) {
        return Failure(
            AuthError.withCode(AuthErrorCode.facebookSignInCancelled));
      }

      return Failure(
        AuthError(
          e.message,
          AuthErrorCode.authenticationFailed,
        ),
      );
    } catch (e) {
      if (_looksCancelled(e)) {
        return Failure(
            AuthError.withCode(AuthErrorCode.facebookSignInCancelled));
      }

      return Failure(UnknownError());
    }
  }

  Future<Result<bool>> _signInWithFacebookProvider() async {
    try {
      final facebookProvider = FacebookAuthProvider()
        ..addScope('email')
        ..addScope('public_profile');
      final userCredential = await auth.signInWithProvider(facebookProvider);
      await _persistSocialUser(
        userCredential,
        fallbackName: 'Usuario Facebook',
      );

      return Success(true);
    } on FirebaseAuthException catch (e) {
      if (_isSignInCancelled(e)) {
        return Failure(
          AuthError.withCode(AuthErrorCode.facebookSignInCancelled),
        );
      }

      return Failure(
        AuthError(
          e.message,
          AuthErrorCode.authenticationFailed,
        ),
      );
    } catch (e) {
      if (_looksCancelled(e)) {
        return Failure(
          AuthError.withCode(AuthErrorCode.facebookSignInCancelled),
        );
      }

      return Failure(UnknownError());
    }
  }

  Future<void> _persistSocialUser(
    UserCredential userCredential, {
    String fallbackName = 'Usuario',
  }) async {
    if (userCredential.additionalUserInfo?.isNewUser ?? false) {
      final userModel = UserModel(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? fallbackName,
        email: userCredential.user!.email ?? '',
      );

      await firebaseService.setData(
        collection: 'users',
        docId: userModel.uid,
        data: userModel.toFirestore(),
        merge: true,
      );
    }
  }

  bool _isSignInCancelled(FirebaseAuthException error) {
    return error.code == 'ERROR_ABORTED_BY_USER' ||
        error.code == 'web-context-cancelled' ||
        error.code == 'cancelled-popup-request' ||
        error.code == 'popup-closed-by-user';
  }

  bool _looksCancelled(Object error) {
    final message = error.toString().toLowerCase();
    return message.contains('cancel') || message.contains('canceled');
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await facebookAuthService.logOut();
    await auth.signOut();
  }
}
