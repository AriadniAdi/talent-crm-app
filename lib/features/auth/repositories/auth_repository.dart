import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';

abstract class AuthRepository {
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

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<bool>> registerUser({
    required String name,
    required String email,
    required String password,
  }) {
    return remoteDataSource.registerUser(
      name: name,
      email: email,
      password: password,
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
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }
}
