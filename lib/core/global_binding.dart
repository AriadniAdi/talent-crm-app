import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';
import 'package:talent_crm_app/features/talent/data/repositories/talent_repository_impl.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Infra
    Get.put<http.Client>(http.Client(), permanent: true);

    Get.put<ApiClient>(
      ApiClient(Get.find<http.Client>()),
      permanent: true,
    );

    // Data (compartilhado)
    Get.lazyPut<TalentRemoteDataSource>(
      () => TalentRemoteDataSource(apiClient: Get.find()),
      fenix: true,
    );

    Get.lazyPut<AuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSource(
        auth: FirebaseAuth.instance,
        db: FirebaseFirestore.instance,
      ),
      fenix: true,
    );

    // Presentation
    Get.lazyPut<TalentRepository>(
      () => TalentRepositoryImpl(Get.find()),
      fenix: true,
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find()),
      fenix: true,
    );
  }
}
