import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Domain
    Get.lazyPut<GetTalentsUseCase>(() => GetTalentsUseCase(Get.find()));

    // Presentation
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
