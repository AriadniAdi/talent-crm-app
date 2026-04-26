import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/account/data/datasources/user_remote_data_source.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';

abstract class UserRepository {
  Future<Result<UserModel?>> getUser(String uid);
  Future<Result<bool>> updateUser(UserModel user);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<UserModel?>> getUser(String uid) async {
    try {
      final user = await remoteDataSource.getUser(uid);
      return Success(user);
    } catch (e) {
      return Failure(UnknownError());
    }
  }

  @override
  Future<Result<bool>> updateUser(UserModel user) async {
    try {
      await remoteDataSource.updateUser(user);
      return Success(true);
    } catch (e) {
      return Failure(UnknownError());
    }
  }
}
