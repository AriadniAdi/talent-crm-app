import 'package:get/get.dart';
import 'package:talent_crm_app/features/auth/presentation/controller/login_controller.dart';

class LoginBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(authRepository: Get.find()),
    );
  }
}
