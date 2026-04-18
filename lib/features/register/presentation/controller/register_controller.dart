import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/errors/app_error_extension.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_contract.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';
import 'package:talent_crm_app/features/register/domain/validators/register_validator.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

class RegisterController extends GetxController {
  final RegisterContract registerUseCase;

  RegisterController(this.registerUseCase);

  final cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'\d')},
  );

  final dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'\d')},
  );

  final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'\d')},
  );

  final isLoading = false.obs;
  final screenError = Rxn<AppError>();
  final validationErrors = <AppError>[].obs;

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final selectedCountryCode = '+55'.obs;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final birthDateController = TextEditingController();

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    cpfController.dispose();
    birthDateController.dispose();

    super.onClose();
  }

  // UI Helpers

  bool hasError(FieldType field) {
    return validationErrors
        .any((e) => e is ValidationError && e.field == field);
  }

  String? getErrorMessage(FieldType field, BuildContext context) {
    final error = validationErrors.firstWhereOrNull(
      (e) => e is ValidationError && e.field == field,
    );

    if (error == null) return null;

    return (error as ValidationError).message(context);
  }

  void _setFieldError(ValidationError error) {
    validationErrors.removeWhere(
      (e) => e is ValidationError && e.field == error.field,
    );

    validationErrors.add(error);
  }

  void _clearFieldError(FieldType field) {
    validationErrors.removeWhere(
      (e) => e is ValidationError && e.field == field,
    );
  }

  // Field validations

  void onBirthDateChanged(String value) {
    _clearFieldError(FieldType.birthDate);

    if (value.length < 10) return;

    final birthDate = _tryParseBirthDate(value);

    if (birthDate == null) {
      _setFieldError(
        ValidationError(
          ValidationErrorType.invalidBirthDate,
          FieldType.birthDate,
        ),
      );
      return;
    }

    if (_isFutureDate(birthDate)) {
      _setFieldError(
        ValidationError(
          ValidationErrorType.futureBirthDate,
          FieldType.birthDate,
        ),
      );
      return;
    }

    if (_isTooOld(birthDate)) {
      _setFieldError(ValidationError(
        ValidationErrorType.tooOld,
        FieldType.birthDate,
      ));
    }

    if (!_isAdult(birthDate)) {
      _setFieldError(
        ValidationError(
          ValidationErrorType.underAge,
          FieldType.birthDate,
        ),
      );
    }
  }

  DateTime? _tryParseBirthDate(String value) {
    final parts = value.split('/');

    if (parts.length != 3) return null;

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) return null;

    final date = DateTime(year, month, day);

    if (date.day != day || date.month != month || date.year != year) {
      return null;
    }

    return date;
  }

  void onNameChanged(String value) {
    _clearFieldError(FieldType.name);

    final name = value.trim();

    if (name.isEmpty) return;

    if (name.length > 120) {
      _setFieldError(ValidationError(
        ValidationErrorType.invalidNameLength,
        FieldType.name,
      ));
    } else if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(name)) {
      _setFieldError(ValidationError(
        ValidationErrorType.invalidName,
        FieldType.name,
      ));
    }
  }

  void onEmailChanged(String value) {
    _clearFieldError(FieldType.email);

    if (value.isEmpty) return;

    if (!value.contains('@')) {
      _setFieldError(ValidationError(
        ValidationErrorType.invalidEmail,
        FieldType.email,
      ));
    }
  }

  void onPasswordChanged(String value) {
    _clearFieldError(FieldType.password);

    if (value.isEmpty) return;

    if (value.length > 6) {
      _setFieldError(ValidationError(
        ValidationErrorType.passwordTooLong,
        FieldType.password,
      ));
    }
  }

  void onConfirmPasswordChanged(String value) {
    _clearFieldError(FieldType.confirmPassword);

    if (value.isEmpty) return;

    if (value != passwordController.text) {
      _setFieldError(ValidationError(
        ValidationErrorType.passwordMismatch,
        FieldType.confirmPassword,
      ));
    }
  }

  void onCpfChanged(String value) {
    _clearFieldError(FieldType.cpf);

    final cpf = value.replaceAll(RegExp(r'\D'), '');

    if (cpf.length < 11) return;

    if (!_isValidCPF(cpf)) {
      _setFieldError(ValidationError(
        ValidationErrorType.invalidCpf,
        FieldType.cpf,
      ));
    }
  }

  void onPhoneChanged(String value) {
    _clearFieldError(FieldType.phone);

    if (value.isEmpty) return;

    if (value.length < 10) {
      _setFieldError(ValidationError(
        ValidationErrorType.requiredPhone,
        FieldType.phone,
      ));
    }
  }

  // Register com validação completa

  Future<void> register() async {
    screenError.value = null;
    validationErrors.clear();

    DateTime? birthDate;

    try {
      birthDate = _parseBirthDate();
    } catch (_) {
      validationErrors.add(
        ValidationError(
          ValidationErrorType.invalidBirthDate,
          FieldType.birthDate,
        ),
      );
    }

    final params = RegisterParams(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      phone: phoneController.text,
      countryCode: selectedCountryCode.value,
      cpf: cpfController.text.replaceAll(RegExp(r'\D'), ''),
      birthDate: birthDate,
    );

    final errors = RegisterValidator.validate(params);

    if (errors.isNotEmpty) {
      validationErrors.assignAll(errors);
      return;
    }

    isLoading.value = true;

    try {
      await registerUseCase(params);
      final l10n = lookupAppLocalizations(Get.locale ?? const Locale('pt'));
      Get.snackbar(
        l10n.registerSuccessTitle,
        l10n.registerSuccessMessage,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on AppError catch (e) {
      screenError.value = e;
    } catch (_) {
      screenError.value = UnknownError();
    } finally {
      isLoading.value = false;
    }
  }

  // Helpers

  bool _isTooOld(DateTime date) {
    final today = DateTime.now();

    final limitDate = DateTime(
      today.year - 100,
      today.month,
      today.day,
    );

    return date.isBefore(limitDate);
  }

  bool _isFutureDate(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return normalizedDate.isAfter(normalizedToday);
  }

  bool _isAdult(DateTime date) {
    final today = DateTime.now();
    int age = today.year - date.year;

    if (today.month < date.month ||
        (today.month == date.month && today.day < date.day)) {
      age--;
    }

    return age >= 18;
  }

  DateTime _parseBirthDate() {
    final date = _tryParseBirthDate(birthDateController.text);
    if (date == null) throw Exception();
    return date;
  }

  bool _isValidCPF(String cpf) {
    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    int calcDigit(String str, int factor) {
      int total = 0;
      for (var i = 0; i < str.length; i++) {
        total += int.parse(str[i]) * factor--;
      }
      final result = total % 11;
      return result < 2 ? 0 : 11 - result;
    }

    final d1 = calcDigit(cpf.substring(0, 9), 10);
    final d2 = calcDigit(cpf.substring(0, 10), 11);

    return cpf == '${cpf.substring(0, 9)}$d1$d2';
  }

  // Actions

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void toggleConfirmPasswordVisibility() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void setCountryCode(String code) => selectedCountryCode.value = code;
}
