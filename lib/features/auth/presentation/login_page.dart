import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class LoginPage extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onContinueWithEmail;
  final VoidCallback onContinueWithGoogle;
  final VoidCallback onContinueWithFacebook;
  static const googleButtonKey = Key('social-button-google');
  static const facebookButtonKey = Key('social-button-facebook');

  const LoginPage({
    super.key,
    required this.isLoading,
    required this.onContinueWithEmail,
    required this.onContinueWithGoogle,
    required this.onContinueWithFacebook,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final t = context.translate;

    return BasePage(
      key: const Key('login-page'),
      showAppBar: false,
      showBackButton: false,
      padding: EdgeInsets.zero,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TalentLogo(size: 22),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        t.appTitle,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppBanner(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.loginHeadline,
                      style: textTheme.headlineSmall?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      t.loginDescription,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                t.loginOptionsTitle,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                t.loginOptionsSubtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              _SocialButton(
                buttonKey: googleButtonKey,
                label: t.continueWithGoogle,
                description: t.continueWithGoogleDescription,
                badgeLabel: 'G',
                badgeColor: const Color(0xFFDB4437),
                onPressed: isLoading ? null : onContinueWithGoogle,
              ),
              const SizedBox(height: 14),
              _SocialButton(
                buttonKey: facebookButtonKey,
                label: t.continueWithFacebook,
                description: t.continueWithFacebookDescription,
                badgeLabel: 'f',
                badgeColor: const Color(0xFF1877F2),
                onPressed: isLoading ? null : onContinueWithFacebook,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: colors.outline.withValues(alpha: 0.18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      t.orDivider,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: colors.outline.withValues(alpha: 0.18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppPrimaryButton(
                label: t.continueWithEmail,
                isLoading: isLoading,
                onPressed: onContinueWithEmail,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register),
                child: Text(t.createAccountWithEmail),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colors.outline.withValues(alpha: 0.14),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.loginProtectionMessage,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Key? buttonKey;
  final String label;
  final String description;
  final VoidCallback? onPressed;
  final Color badgeColor;
  final String? badgeLabel;
  final IconData? badgeIcon;

  const _SocialButton({
    this.buttonKey,
    required this.label,
    required this.description,
    required this.onPressed,
    required this.badgeColor,
    this.badgeLabel,
    this.badgeIcon,
  }) : assert(
          badgeLabel != null || badgeIcon != null,
          'Provide badgeLabel or badgeIcon.',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isEnabled = onPressed != null;

    return Material(
      color:
          isEnabled ? colors.surface : colors.surface.withValues(alpha: 0.78),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        key: buttonKey,
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colors.outline.withValues(alpha: isEnabled ? 0.16 : 0.08),
            ),
          ),
          child: Row(
            children: [
              _SocialBadge(
                color: badgeColor,
                label: badgeLabel,
                icon: badgeIcon,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isEnabled
                            ? null
                            : colors.onSurface.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isEnabled
                            ? AppColors.textSecondary
                            : AppColors.textSecondary.withValues(alpha: 0.78),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isEnabled
                    ? colors.primary
                    : colors.onSurface.withValues(alpha: 0.32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialBadge extends StatelessWidget {
  final Color color;
  final String? label;
  final IconData? icon;

  const _SocialBadge({
    required this.color,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, color: Colors.white, size: 24)
            : Text(
                label!,
                style: textStyle?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
