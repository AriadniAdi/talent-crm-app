import 'package:get/get.dart';
import 'package:talent_crm_app/features/auth/presentation/forgot_password/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(authRepository: Get.find()),
    );
  }
}
