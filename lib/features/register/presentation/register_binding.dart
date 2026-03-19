import 'package:get/get.dart';
import 'package:talent_crm_app/features/register/presentation/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
