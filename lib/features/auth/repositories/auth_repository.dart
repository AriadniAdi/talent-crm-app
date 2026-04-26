import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

abstract class AuthRepository {
  Future<Result<UserModel>> getUserProfile({
    required String uid,
  });

  Future<Result<bool>> updateUserProfile({
    required UserModel user,
  });

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

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<UserModel>> getUserProfile({
    required String uid,
  }) {
    return remoteDataSource.getUserProfile(uid: uid);
  }

  @override
  Future<Result<bool>> updateUserProfile({
    required UserModel user,
  }) {
    return remoteDataSource.updateUserProfile(user: user);
  }

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
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }
}
