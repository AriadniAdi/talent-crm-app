import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';

abstract class AuthRepository {
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

  Future<Result<bool>> signInWithFacebook();

  Future<Result<bool>> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signOut();

  Future<Result<void>> sendEmailVerification();

  Future<Result<void>> reloadUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
    required String? phone,
    required String? countryCode,
    required String? cpf,
    required DateTime? birthDate,
  }) {
    return remoteDataSource.registerUser(
      name: name,
      email: email,
      password: password,
      phone: phone,
      countryCode: countryCode,
      cpf: cpf,
      birthDate: birthDate,
    );
  }

  @override
  Future<Result<bool>> signIn({
    required String email,
    required String password,
  }) {
    return remoteDataSource.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<Result<bool>> signInWithGoogle() {
    return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<Result<bool>> signInWithFacebook() {
    return remoteDataSource.signInWithFacebook();
  }

  @override
  Future<Result<bool>> sendPasswordResetEmail({
    required String email,
  }) {
    return remoteDataSource.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<Result<void>> sendEmailVerification() {
    return remoteDataSource.sendEmailVerification();
  }

  @override
  Future<Result<void>> reloadUser() {
    return remoteDataSource.reloadUser();
  }
}
