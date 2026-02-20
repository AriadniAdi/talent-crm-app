import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/data/services/talent/talent_service.dart';
import 'package:talent_crm_app/domain/repositories/talent_repository.dart';
import 'package:talent_crm_app/domain/usecases/talent/get_talent_usecase.dart';
import 'package:talent_crm_app/presentation/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Infra
    Get.lazyPut<http.Client>(() => http.Client());

    // Data
    Get.lazyPut<TalentService>(() => TalentService(Get.find()));

    Get.lazyPut<TalentRepository>(() => TalentRepositoryImpl(Get.find()));

    // Domain
    Get.lazyPut<GetTalentsUseCase>(() => GetTalentsUseCase(Get.find()));

    // Presentation
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
