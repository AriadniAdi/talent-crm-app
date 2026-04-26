import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/account/data/datasources/user_remote_data_source.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/repositories/user_repository.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRemoteDataSource>(
        () => FirebaseUserRemoteDataSource(FirebaseFirestore.instance));
    Get.lazyPut<UserRepository>(
        () => UserRepositoryImpl(Get.find<UserRemoteDataSource>()));
    Get.lazyPut(() => AccountController());
  }
}
