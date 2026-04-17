import 'package:get/get.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_contract.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_usecase.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Domain
    Get.lazyPut<RegisterContract>(() => RegisterUseCase(Get.find()));

    // Presentation
    Get.lazyPut<RegisterController>(() => RegisterController(Get.find()));
  }
}
