import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/pages/base_page.dart';
import 'package:talent_crm_app/l10n/translate.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController fullNameController,
      emailController,
      passwordController,
      confirmPasswordController,
      phoneController,
      cpfController,
      birthDateController;

  final List<TextInputFormatter>? cpfFormatters;
  final List<TextInputFormatter>? dateFormatters;
  final List<TextInputFormatter>? phoneFormatters;

  final bool obscurePassword, obscureConfirmPassword, isLoading;
  final String selectedCountryCode;
  final String? errorMessage;
  final List<String> errorMessages;
  final bool Function(FieldType field) hasError;
  final String? Function(FieldType field, BuildContext context) getErrorMessage;

  final ValueChanged<String>? onBirthDateChanged;

  final VoidCallback onTogglePassword,
      onToggleConfirmPassword,
      onRegister,
      onCountryTap;

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
    required this.isLoading,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onRegister,
    required this.onCountryTap,
    required this.cpfController,
    required this.birthDateController,
    required this.errorMessage,
    required this.errorMessages,
    required this.hasError,
    required this.getErrorMessage,
    required this.onBirthDateChanged,
    required this.cpfFormatters,
    required this.dateFormatters,
    required this.phoneFormatters,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.translate.createAccount,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.translate.fillOnTheContinue,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              _RegisterTextField(
                fieldKey: const Key('register_full_name_field'),
                controller: fullNameController,
                hintText: context.translate.fullName,
                prefixIcon: Icons.person_outline,
                hasError: hasError(FieldType.name),
                errorText: getErrorMessage(FieldType.name, context),
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                fieldKey: const Key('register_cpf_field'),
                controller: cpfController,
                hintText: context.translate.cpf,
                prefixIcon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: cpfFormatters,
                hasError: hasError(FieldType.cpf),
                errorText: getErrorMessage(FieldType.cpf, context),
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                fieldKey: const Key('register_birth_date_field'),
                controller: birthDateController,
                hintText: context.translate.birthDateHint,
                prefixIcon: Icons.calendar_today_outlined,
                keyboardType: TextInputType.datetime,
                inputFormatters: dateFormatters,
                hasError: hasError(FieldType.birthDate),
                errorText: getErrorMessage(FieldType.birthDate, context),
                onChanged: onBirthDateChanged,
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                fieldKey: const Key('register_email_field'),
                controller: emailController,
                hintText: context.translate.email,
                prefixIcon: Icons.mail_outline,
                hasError: hasError(FieldType.email),
                errorText: getErrorMessage(FieldType.email, context),
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                fieldKey: const Key('register_password_field'),
                controller: passwordController,
                hintText: context.translate.password,
                prefixIcon: Icons.lock_outline,
                obscureText: obscurePassword,
                hasError: hasError(FieldType.password),
                suffixIcon: IconButton(
                  key: const Key('register_password_toggle'),
                  onPressed: onTogglePassword,
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                errorText: getErrorMessage(FieldType.password, context),
              ),
              const SizedBox(height: 16),
              _RegisterTextField(
                fieldKey: const Key('register_confirm_password_field'),
                controller: confirmPasswordController,
                hintText: context.translate.confirmPassword,
                prefixIcon: Icons.lock_outline,
                obscureText: obscureConfirmPassword,
                suffixIcon: IconButton(
                  key: const Key('register_confirm_password_toggle'),
                  onPressed: onToggleConfirmPassword,
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                hasError: hasError(FieldType.confirmPassword),
                errorText: getErrorMessage(FieldType.confirmPassword, context),
              ),
              const SizedBox(height: 16),
              _PhoneField(
                countrySelectorKey: const Key('register_country_selector'),
                phoneFieldKey: const Key('register_phone_field'),
                countryCode: selectedCountryCode,
                phoneController: phoneController,
                onCountryTap: onCountryTap,
                inputFormatters: phoneFormatters,
                hasError: hasError(FieldType.phone),
                errorText: getErrorMessage(FieldType.phone, context),
              ),
              const SizedBox(height: 24),
              if (errorMessage != null) ...[
                const SizedBox(height: 4),
                Text(
                  errorMessage!,
                  key: const Key('register_general_error'),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              SizedBox(
                height: 58,
                child: ElevatedButton(
                  key: const Key('register_submit_button'),
                  onPressed: () {
                    if (!isLoading) onRegister();
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            key: Key('register_submit_loading'),
                            strokeWidth: 2,
                          ))
                      : Text(context.translate.register),
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
  final Key? fieldKey;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText, hasError;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const _RegisterTextField(
      {this.fieldKey,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.onChanged,
      this.inputFormatters,
      required this.hasError,
      required this.errorText});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      key: fieldKey,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        errorText: errorText,
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
            color:
                hasError ? Colors.red : colors.outline.withValues(alpha: 0.18),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color:
                hasError ? Colors.red : colors.outline.withValues(alpha: 0.18),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color:
                hasError ? Colors.red : colors.primary.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final Key? countrySelectorKey, phoneFieldKey;
  final String countryCode;
  final TextEditingController phoneController;
  final VoidCallback onCountryTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool hasError;
  final String? errorText;

  const _PhoneField({
    this.countrySelectorKey,
    this.phoneFieldKey,
    required this.countryCode,
    required this.phoneController,
    required this.onCountryTap,
    required this.inputFormatters,
    required this.hasError,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 62,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: hasError
                  ? Colors.red
                  : colors.outline.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                key: countrySelectorKey,
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
                  key: phoneFieldKey,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    hintText: context.translate.phone,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
