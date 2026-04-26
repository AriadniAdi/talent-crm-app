import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/features/auth/presentation/forgot_password/forgot_password_controller.dart';
import 'package:talent_crm_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

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
          child: Obx(
            () => controller.hasSentEmail.value
                ? _SuccessState(
                    email: controller.submittedEmail.value,
                    onEditEmail: controller.editEmail,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_reset_outlined,
                            size: 56,
                            color: colors.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            context.translate.forgotPasswordTitle,
                            textAlign: TextAlign.center,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.translate.forgotPasswordSubtitle,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                              fontSize: 18,
                              height: 1.4,
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
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: colors.outline.withValues(alpha: 0.14),
                          ),
                        ),
                        child: Text(
                          context.translate.forgotPasswordHelper,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.45,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AppPrimaryButton(
                        label: context.translate.sendRecoveryEmail,
                        isLoading: controller.isLoading.value,
                        onPressed: controller.sendResetEmail,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  final String email;
  final VoidCallback onEditEmail;

  const _SuccessState({
    required this.email,
    required this.onEditEmail,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Icon(
          Icons.mark_email_read_outlined,
          size: 64,
          color: colors.primary,
        ),
        const SizedBox(height: 16),
        Text(
          context.translate.passwordResetEmailSentTitle,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          context.translate.passwordResetEmailSentMessage(email),
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 28),
        AppPrimaryButton(
          label: context.translate.backToLogin,
          onPressed: () => Get.offNamed(AppRoutes.loginEmail),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: onEditEmail,
          child: Text(context.translate.useAnotherEmail),
        ),
      ],
    );
  }
}
