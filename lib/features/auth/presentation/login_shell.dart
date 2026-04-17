import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/auth/presentation/controller/login_controller.dart';
import 'package:talent_crm_app/features/auth/presentation/login_page.dart';

class LoginShell extends GetView<LoginController> {
  const LoginShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoginPage(
        isLoading: controller.isLoading.value,
        onContinueWithEmail: controller.continueWithEmail,
      ),
    );
  }
}
