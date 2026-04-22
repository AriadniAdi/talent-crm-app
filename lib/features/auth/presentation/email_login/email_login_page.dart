import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/auth/presentation/email_login/email_login_controller.dart';
import 'package:talent_crm_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class EmailLoginPage extends GetView<EmailLoginController> {
  const EmailLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BasePage(
      showAppBar: true,
      showBackButton: true,
      padding: EdgeInsets.zero,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.translate.emailLoginTitle,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.translate.emailLoginSubtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
              AuthTextField(
                controller: controller.emailController,
                hintText: context.translate.email,
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              Obx(() => AuthTextField(
                    controller: controller.passwordController,
                    hintText: context.translate.password,
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.obscurePassword.value,
                    suffixIcon: IconButton(
                      onPressed: controller.togglePasswordVisibility,
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  )),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed(
                    AppRoutes.forgotPassword,
                    arguments: {
                      'email': controller.emailController.text,
                    },
                  ),
                  child: Text(context.translate.forgotPasswordAction),
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () => AppPrimaryButton(
                  label: context.translate.signIn,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.signIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
