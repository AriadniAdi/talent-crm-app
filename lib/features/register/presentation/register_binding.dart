import 'package:get/get.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_usecase.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Domain
    Get.lazyPut<RegisterUseCase>(() => const RegisterUseCase());

    // Presentation
    Get.lazyPut<RegisterController>(() => RegisterController(Get.find()));
  }
}
