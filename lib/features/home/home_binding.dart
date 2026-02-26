import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/config/app_config.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/services/talent_service.dart';
import 'package:talent_crm_app/features/talent/repositories/talent_repository.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Data
    Get.lazyPut<TalentService>(() => TalentService(
        baseUrl: AppConfig.baseUrl, client: Get.find<http.Client>()));
    Get.lazyPut<TalentRepository>(() => TalentRepositoryImpl(Get.find()));

    // Domain
    Get.lazyPut<GetTalentsUseCase>(() => GetTalentsUseCase(Get.find()));

    // Presentation
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
