import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/core/firebase/firebase_service.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseService extends Mock implements FirebaseService {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class MockAdditionalUserInfo extends Mock implements AdditionalUserInfo {}

class FakeGoogleSignInAuthentication extends Fake implements GoogleSignInAuthentication {
  @override
  String? get idToken => 'id-token';
}

class FakeGoogleSignInClientAuthorization extends Fake implements GoogleSignInClientAuthorization {
  @override
  String get accessToken => 'access-token';
}

class FakeGoogleSignInAuthorizationClient extends Fake implements GoogleSignInAuthorizationClient {
  @override
  Future<GoogleSignInClientAuthorization> authorizeScopes(List<String> scopes) async {
    return FakeGoogleSignInClientAuthorization();
  }
}

class FakeGoogleSignInAccount extends Fake implements GoogleSignInAccount {
  @override
  GoogleSignInAuthentication get authentication => FakeGoogleSignInAuthentication();

  @override
  GoogleSignInAuthorizationClient get authorizationClient => FakeGoogleSignInAuthorizationClient();

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
  late FirebaseAuthRemoteDataSource dataSource;

  late MockUserCredential userCredential;
  late MockUser user;

  setUpAll(() {
    registerFallbackValue(DateTime.now());
    registerFallbackValue(const AuthCredential(
      providerId: 'providerId',
      signInMethod: 'signInMethod',
    ));
  });

  setUp(() {
    auth = MockFirebaseAuth();
    firebaseService = MockFirebaseService();
    googleSignIn = MockGoogleSignIn();
    dataSource = FirebaseAuthRemoteDataSource(
      auth: auth,
      firebaseService: firebaseService,
      googleSignIn: googleSignIn,
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
    const bio = 'Flutter dev';
    final birthDate = DateTime(1990, 1, 1);

    group('getUserProfile', () {
      test('returns user profile when document exists', () async {
        when(() => firebaseService.getData(
              collection: 'users',
              docId: 'test-uid',
            )).thenAnswer(
          (_) async => {
            'uid': 'test-uid',
            'name': name,
            'email': email,
            'phone': phone,
            'country_code': countryCode,
            'cpf': cpf,
            'bio': bio,
          },
        );

        final result = await dataSource.getUserProfile(uid: 'test-uid');

        result.when(
          success: (user) {
            expect(user.uid, 'test-uid');
            expect(user.name, name);
            expect(user.bio, bio);
          },
          failure: (_) => fail('Should have succeeded'),
        );
      });

      test('returns not found when document does not exist', () async {
        when(() => firebaseService.getData(
              collection: 'users',
              docId: 'missing',
            )).thenAnswer((_) async => null);

        final result = await dataSource.getUserProfile(uid: 'missing');

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<NotFoundError>());
          },
        );
      });
    });

    group('updateUserProfile', () {
      test('stores the updated user in firestore', () async {
        when(() => firebaseService.setData(
              collection: any(named: 'collection'),
              docId: any(named: 'docId'),
              data: any(named: 'data'),
              merge: any(named: 'merge'),
            )).thenAnswer((_) async => {});

        final result = await dataSource.updateUserProfile(
          user: UserModel(
            uid: 'test-uid',
            name: name,
            email: email,
            phone: phone,
            countryCode: countryCode,
            cpf: cpf,
            bio: bio,
            birthDate: birthDate,
          ),
        );

        expect(result, isA<Success<bool>>());
        verify(() => firebaseService.setData(
              collection: 'users',
              docId: 'test-uid',
              data: any(named: 'data'),
              merge: true,
            )).called(1);
      });
    });

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
        
        verify(() => auth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
        verify(() => firebaseService.setData(
          collection: 'users',
          docId: 'test-uid',
          data: any(named: 'data'),
        )).called(1);
      });

      test('returns AuthError when firebase throws email-already-in-use', () async {
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

        when(() => googleSignIn.authenticate()).thenAnswer((_) async => mockGoogleAccount);
        
        when(() => auth.signInWithCredential(any())).thenAnswer((_) async => userCredential);
        when(() => userCredential.additionalUserInfo).thenReturn(mockAdditionalInfo);
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
        when(() => googleSignIn.authenticate()).thenThrow(Exception('canceled'));

        final result = await dataSource.signInWithGoogle();

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect((error as AuthError).code, AuthErrorCode.googleSignInCancelled);
          },
        );
      });
    });

    group('signIn', () {
      test('maps invalid-credential to invalid credentials', () async {
        when(
          () => auth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

        final result = await dataSource.signIn(
          email: email,
          password: password,
        );

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<AuthError>());
            expect((error as AuthError).code, AuthErrorCode.invalidCredentials);
          },
        );
      });

      test('maps network-request-failed to NetworkError', () async {
        when(
          () => auth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: 'network-request-failed'));

        final result = await dataSource.signIn(
          email: email,
          password: password,
        );

        result.when(
          success: (_) => fail('Should have failed'),
          failure: (error) {
            expect(error, isA<NetworkError>());
          },
        );
      });
    });
  });
}
