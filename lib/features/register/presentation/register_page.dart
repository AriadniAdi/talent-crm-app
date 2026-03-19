import 'package:flutter/material.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String selectedCountryCode;
  final bool acceptedTerms;
  final bool isLoading;

  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onToggleTerms;
  final VoidCallback onRegister;
  final VoidCallback onCountryTap;

  const RegisterPage({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.selectedCountryCode,
    required this.acceptedTerms,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onToggleTerms,
    required this.onRegister,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 36),
              _RegisterTextField(
                controller: fullNameController,
                hintText: 'Nome completo',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                controller: emailController,
                hintText: 'E-mail',
                prefixIcon: Icons.mail_outline,
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                controller: passwordController,
                hintText: 'Senha',
                prefixIcon: Icons.lock_outline,
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                controller: confirmPasswordController,
                hintText: 'Confirmar senha',
                prefixIcon: Icons.lock_outline,
                obscureText: obscureConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: onToggleConfirmPassword,
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _PhoneField(
                countryCode: selectedCountryCode,
                phoneController: phoneController,
                onCountryTap: onCountryTap,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Checkbox(
                    value: acceptedTerms,
                    onChanged: (_) => onToggleTerms(),
                  ),
                  const Expanded(
                    child: Text('Eu aceito os termos'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLoading) onRegister();
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const _RegisterTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    // ignore: unused_element_parameter
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: colors.primary),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: colors.outline.withValues(alpha: 0.18),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: colors.outline.withValues(alpha: 0.18),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: colors.primary.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final String countryCode;
  final TextEditingController phoneController;
  final VoidCallback onCountryTap;

  const _PhoneField({
    required this.countryCode,
    required this.phoneController,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onCountryTap,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(28),
            ),
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: colors.outline.withValues(alpha: 0.18),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_outlined, color: colors.primary),
                  const SizedBox(width: 8),
                  Text(
                    countryCode,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colors.primary,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Telefone',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
