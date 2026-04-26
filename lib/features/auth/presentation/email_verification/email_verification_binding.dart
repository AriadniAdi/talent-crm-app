import 'package:get/get.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/features/auth/presentation/email_verification/email_verification_controller.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(
      () => EmailVerificationController(Get.find<AuthRepository>()),
    );
  }
}
