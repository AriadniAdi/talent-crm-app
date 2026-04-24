import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talent_crm_app/core/auth/facebook_auth_service.dart';
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/features/talent/data/datasources/talent_remote_data_source.dart';
import 'package:talent_crm_app/features/talent/data/repositories/talent_repository_impl.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/core/auth_manager.dart';
import 'package:talent_crm_app/core/firebase/firebase_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Firebase (allows mocks to be pre-registered in tests)
    if (!Get.isRegistered<FirebaseAuth>()) {
      Get.put<FirebaseAuth>(FirebaseAuth.instance, permanent: true);
    }
    if (!Get.isRegistered<FirebaseFirestore>()) {
      Get.put<FirebaseFirestore>(FirebaseFirestore.instance, permanent: true);
    }
    if (!Get.isRegistered<GoogleSignIn>()) {
      Get.put<GoogleSignIn>(GoogleSignIn.instance, permanent: true);
    }

    Get.put<FirebaseService>(
      FirebaseFirestoreService(Get.find<FirebaseFirestore>()),
      permanent: true,
    );
    Get.put<FacebookAuthService>(
      FlutterFacebookAuthService(),
      permanent: true,
    );

    // Auth global
    Get.put<AuthManager>(
      AuthManager(auth: Get.find<FirebaseAuth>()),
      permanent: true,
    );

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
        auth: Get.find<FirebaseAuth>(),
        firebaseService: Get.find<FirebaseService>(),
        googleSignIn: Get.find<GoogleSignIn>(),
        facebookAuthService: Get.find<FacebookAuthService>(),
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
