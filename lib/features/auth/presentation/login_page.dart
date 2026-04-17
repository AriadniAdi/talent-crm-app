import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onContinueWithEmail;

  const LoginPage({
    super.key,
    required this.isLoading,
    required this.onContinueWithEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

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
                        'Talent CRM',
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
                      'Acesse sua conta',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Entre com sua conta social ou continue com e-mail para acompanhar candidatos, equipes e oportunidades.',
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
                'Escolha como deseja entrar',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Um fluxo simples, rápido e familiar para começar.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              _SocialButton(
                label: 'Continuar com Google',
                description: 'Use a conta conectada ao seu dispositivo.',
                badgeLabel: 'G',
                badgeColor: const Color(0xFFDB4437),
                onPressed: () => _showComingSoon(context, 'Google'),
              ),
              const SizedBox(height: 14),
              _SocialButton(
                label: 'Continuar com Apple',
                description: 'Ideal para um acesso rapido e privado.',
                badgeIcon: Icons.apple_rounded,
                badgeColor: Colors.black,
                onPressed: () => _showComingSoon(context, 'Apple'),
              ),
              const SizedBox(height: 14),
              _SocialButton(
                label: 'Continuar com Facebook',
                description: 'Entre com seu perfil social tradicional.',
                badgeLabel: 'f',
                badgeColor: const Color(0xFF1877F2),
                onPressed: () => _showComingSoon(context, 'Facebook'),
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
                      'ou',
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
              SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onContinueWithEmail,
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Continuar com e-mail'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register),
                child: const Text('Criar conta com e-mail'),
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
                        'Seus dados de acesso ficam protegidos e voce pode trocar o metodo de login depois.',
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

  void _showComingSoon(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider sera conectado na proxima etapa.'),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onPressed;
  final Color badgeColor;
  final String? badgeLabel;
  final IconData? badgeIcon;

  const _SocialButton({
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

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colors.outline.withValues(alpha: 0.16),
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
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: colors.primary,
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
