import 'package:get/get.dart';
import 'package:talent_crm_app/features/auth/presentation/email_login/email_login_controller.dart';

class EmailLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailLoginController>(
      () => EmailLoginController(authRepository: Get.find()),
    );
  }
}
