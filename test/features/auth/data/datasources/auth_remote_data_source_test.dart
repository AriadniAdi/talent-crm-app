import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/auth/facebook_auth_service.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/firebase/firebase_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseService extends Mock implements FirebaseService {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFacebookAuthService extends Mock implements FacebookAuthService {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockAdditionalUserInfo extends Mock implements AdditionalUserInfo {}

class FakeAuthProvider extends Fake implements AuthProvider {}

class FakeGoogleSignInAuthentication extends Fake
    implements GoogleSignInAuthentication {
  @override
  String? get idToken => 'id-token';
}

class FakeGoogleSignInClientAuthorization extends Fake
    implements GoogleSignInClientAuthorization {
  @override
  String get accessToken => 'access-token';
}

class FakeGoogleSignInAuthorizationClient extends Fake
    implements GoogleSignInAuthorizationClient {
  @override
  Future<GoogleSignInClientAuthorization> authorizeScopes(
      List<String> scopes) async {
    return FakeGoogleSignInClientAuthorization();
  }
}

class FakeGoogleSignInAccount extends Fake implements GoogleSignInAccount {
  @override
  GoogleSignInAuthentication get authentication =>
      FakeGoogleSignInAuthentication();

  @override
  GoogleSignInAuthorizationClient get authorizationClient =>
      FakeGoogleSignInAuthorizationClient();

  @override
  String get displayName => 'Test User';

  @override
  String get email => 'test@example.com';

  @override
  String get id => 'test-id';

  @override
  String? get photoUrl => null;
}

void main() {
  late MockFirebaseAuth auth;
  late MockFirebaseService firebaseService;
  late MockGoogleSignIn googleSignIn;
  late MockFacebookAuthService facebookAuthService;
  late FirebaseAuthRemoteDataSource dataSource;

  late MockUserCredential userCredential;
  late MockUser user;

  setUpAll(() {
    registerFallbackValue(DateTime.now());
    registerFallbackValue(const AuthCredential(
      providerId: 'providerId',
      signInMethod: 'signInMethod',
    ));
    registerFallbackValue(FakeAuthProvider());
  });

  setUp(() {
    auth = MockFirebaseAuth();
    firebaseService = MockFirebaseService();
    googleSignIn = MockGoogleSignIn();
    facebookAuthService = MockFacebookAuthService();
    dataSource = FirebaseAuthRemoteDataSource(
      auth: auth,
      firebaseService: firebaseService,
      googleSignIn: googleSignIn,
      facebookAuthService: facebookAuthService,
      useNativeFacebookSignIn: true,
    );

    userCredential = MockUserCredential();
    user = MockUser();

    when(() => user.uid).thenReturn('test-uid');
    when(() => userCredential.user).thenReturn(user);
  });

  group('FirebaseAuthRemoteDataSource', () {
    const name = 'Test User';
    const email = 'test@example.com';
    const password = 'password123';
    const phone = '11988887777';
    const countryCode = '+55';
    const cpf = '12345678900';
    final birthDate = DateTime(1990, 1, 1);

    group('registerUser', () {
      test('successfully creates user and sets data in firestore', () async {
        when(
          () => auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => userCredential);

        when(() => firebaseService.setData(
              collection: any(named: 'collection'),
              docId: any(named: 'docId'),
              data: any(named: 'data'),
            )).thenAnswer((_) async => {});

        when(() => auth.currentUser).thenReturn(user);
        when(() => user.sendEmailVerification()).thenAnswer((_) async {});

        final result = await dataSource.registerUser(
          name: name,
          email: email,
          password: password,
          phone: phone,
          countryCode: countryCode,
          cpf: cpf,
          birthDate: birthDate,
        );

        expect(result, isA<Success<bool>>());

        verify(() => auth.createUserWithEmailAndPassword(
            email: email, password: password)).called(1);
        verify(() => firebaseService.setData(
              collection: 'users',
              docId: 'test-uid',
              data: any(named: 'data'),
            )).called(1);
        verify(() => user.sendEmailVerification()).called(1);
      });

      test('returns AuthError when firebase throws email-already-in-use',
          () async {
        when(
          () => auth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        final result = await dataSource.registerUser(
          name: name,
          email: email,
          password: password,
          phone: phone,
          countryCode: countryCode,
          cpf: cpf,
          birthDate: birthDate,
        );

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
          },
        );
      });
    });

    group('signInWithGoogle', () {
      test('successfully signs in with google', () async {
        final mockGoogleAccount = FakeGoogleSignInAccount();
        final mockAdditionalInfo = MockAdditionalUserInfo();

        when(() => googleSignIn.authenticate())
            .thenAnswer((_) async => mockGoogleAccount);

        when(() => auth.signInWithCredential(any()))
            .thenAnswer((_) async => userCredential);
        when(() => userCredential.additionalUserInfo)
            .thenReturn(mockAdditionalInfo);
        when(() => mockAdditionalInfo.isNewUser).thenReturn(true);
        when(() => user.displayName).thenReturn(name);
        when(() => user.email).thenReturn(email);

        when(() => firebaseService.setData(
              collection: any(named: 'collection'),
              docId: any(named: 'docId'),
              data: any(named: 'data'),
              merge: any(named: 'merge'),
            )).thenAnswer((_) async => {});

        final result = await dataSource.signInWithGoogle();

        expect(result, isA<Success<bool>>());
        verify(() => googleSignIn.authenticate()).called(1);
        verify(() => auth.signInWithCredential(any())).called(1);
      });

      test('returns failure when user cancels google sign in', () async {
        when(() => googleSignIn.authenticate())
            .thenThrow(Exception('canceled'));

        final result = await dataSource.signInWithGoogle();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect(
                (error as AuthError).code, AuthErrorCode.googleSignInCancelled);
          },
        );
      });

      test(
          'returns failure with provider message on google configuration error',
          () async {
        when(
          () => googleSignIn.authenticate(),
        ).thenThrow(
          const GoogleSignInException(
            code: GoogleSignInExceptionCode.clientConfigurationError,
            description: 'Google Sign-In configuration is invalid.',
          ),
        );

        final result = await dataSource.signInWithGoogle();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect(
                (error as AuthError).code, AuthErrorCode.authenticationFailed);
            expect(error.message, 'Google Sign-In configuration is invalid.');
          },
        );
      });
    });

    group('sendPasswordResetEmail', () {
      test('successfully sends password reset email', () async {
        when(
          () => auth.sendPasswordResetEmail(email: email),
        ).thenAnswer((_) async {});

        final result = await dataSource.sendPasswordResetEmail(email: email);

        expect(result, isA<Success<bool>>());
        verify(() => auth.sendPasswordResetEmail(email: email)).called(1);
      });

      test('returns AuthError when firebase throws user-not-found', () async {
        when(
          () => auth.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

        final result = await dataSource.sendPasswordResetEmail(email: email);

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect((error as AuthError).code, AuthErrorCode.userNotFound);
          },
        );
      });
    });

    group('signInWithFacebook', () {
      test('successfully signs in with facebook', () async {
        final mockAdditionalInfo = MockAdditionalUserInfo();

        when(
          () => facebookAuthService.login(),
        ).thenAnswer(
          (_) async => const FacebookLoginResult(
            status: FacebookLoginStatus.success,
            accessToken: 'facebook-token',
          ),
        );
        when(() => auth.signInWithCredential(any()))
            .thenAnswer((_) async => userCredential);
        when(() => userCredential.additionalUserInfo)
            .thenReturn(mockAdditionalInfo);
        when(() => mockAdditionalInfo.isNewUser).thenReturn(true);
        when(() => user.displayName).thenReturn(name);
        when(() => user.email).thenReturn(email);
        when(() => firebaseService.setData(
              collection: any(named: 'collection'),
              docId: any(named: 'docId'),
              data: any(named: 'data'),
              merge: any(named: 'merge'),
            )).thenAnswer((_) async => {});

        final result = await dataSource.signInWithFacebook();

        expect(result, isA<Success<bool>>());
        verify(() => facebookAuthService.login()).called(1);
        verify(() => auth.signInWithCredential(any())).called(1);
      });

      test('returns cancellation error when facebook sign in is cancelled',
          () async {
        when(
          () => facebookAuthService.login(),
        ).thenAnswer(
          (_) async => const FacebookLoginResult(
            status: FacebookLoginStatus.cancelled,
          ),
        );

        final result = await dataSource.signInWithFacebook();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect((error as AuthError).code,
                AuthErrorCode.facebookSignInCancelled);
          },
        );
      });

      test('returns provider message when facebook sign in fails', () async {
        when(
          () => facebookAuthService.login(),
        ).thenAnswer(
          (_) async => const FacebookLoginResult(
            status: FacebookLoginStatus.failed,
            message: 'Facebook login is not configured.',
          ),
        );

        final result = await dataSource.signInWithFacebook();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect(
                (error as AuthError).code, AuthErrorCode.authenticationFailed);
            expect(error.message, 'Facebook login is not configured.');
          },
        );
      });

      test('returns failure when facebook login succeeds without token',
          () async {
        when(
          () => facebookAuthService.login(),
        ).thenAnswer(
          (_) async => const FacebookLoginResult(
            status: FacebookLoginStatus.success,
          ),
        );

        final result = await dataSource.signInWithFacebook();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect(
                (error as AuthError).code, AuthErrorCode.authenticationFailed);
            expect(
              error.message,
              'Nao foi possivel obter as credenciais do Facebook para continuar.',
            );
          },
        );
      });

      test('returns provider message when facebook login is already running',
          () async {
        when(
          () => facebookAuthService.login(),
        ).thenAnswer(
          (_) async => const FacebookLoginResult(
            status: FacebookLoginStatus.operationInProgress,
            message: 'Facebook login is already in progress.',
          ),
        );

        final result = await dataSource.signInWithFacebook();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect(
                (error as AuthError).code, AuthErrorCode.authenticationFailed);
            expect(error.message, 'Facebook login is already in progress.');
          },
        );
      });
    });

    group('signOut', () {
      test('signs out from providers and firebase auth', () async {
        when(() => googleSignIn.signOut()).thenAnswer((_) async {});
        when(() => facebookAuthService.logOut()).thenAnswer((_) async {});
        when(() => auth.signOut()).thenAnswer((_) async {});

        await dataSource.signOut();

        verify(() => googleSignIn.signOut()).called(1);
        verify(() => facebookAuthService.logOut()).called(1);
        verify(() => auth.signOut()).called(1);
      });
    });

    group('sendEmailVerification', () {
      test('successfully sends verification email', () async {
        when(() => auth.currentUser).thenReturn(user);
        when(() => user.sendEmailVerification()).thenAnswer((_) async {});

        final result = await dataSource.sendEmailVerification();

        expect(result, isA<Success<void>>());
        verify(() => user.sendEmailVerification()).called(1);
      });
    });

    group('reloadUser', () {
      test('successfully reloads user', () async {
        when(() => auth.currentUser).thenReturn(user);
        when(() => user.reload()).thenAnswer((_) async {});

        final result = await dataSource.reloadUser();

        expect(result, isA<Success<void>>());
        verify(() => user.reload()).called(1);
      });
    });
  });
}
