import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/network/api_client.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';

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
    Get.lazyPut<TalentService>(
      () => TalentService(apiClient: Get.find()),
      fenix: true,
    );

    // Presentation
    Get.lazyPut<TalentRepository>(
      () => TalentRepositoryImpl(Get.find()),
      fenix: true,
    );
  }
}
