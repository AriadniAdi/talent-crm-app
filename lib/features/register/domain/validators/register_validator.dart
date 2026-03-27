import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';

class RegisterValidator {
  static List<AppError> validate(RegisterParams params) {
    final errors = <AppError>[];
    final name = params.name.trim();

    if (name.isEmpty) {
      errors.add(ValidationError(
        ValidationErrorType.requiredName,
        FieldType.name,
      ));
    } else if (name.length > 120) {
      errors.add(ValidationError(
        ValidationErrorType.invalidNameLength,
        FieldType.name,
      ));
    } else if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(name)) {
      errors.add(ValidationError(
        ValidationErrorType.invalidName,
        FieldType.name,
      ));
    }

    if (params.cpf.isEmpty) {
      errors.add(ValidationError(
        ValidationErrorType.requiredCpf,
        FieldType.cpf,
      ));
    } else if (!_isValidCPF(params.cpf)) {
      errors.add(ValidationError(
        ValidationErrorType.invalidCpf,
        FieldType.cpf,
      ));
    }

    if (params.birthDate == null) {
      errors.add(ValidationError(
        ValidationErrorType.invalidBirthDate,
        FieldType.birthDate,
      ));
    } else {
      if (_isFutureDate(params.birthDate!)) {
        errors.add(ValidationError(
          ValidationErrorType.futureBirthDate,
          FieldType.birthDate,
        ));
      } else if (!_isAdult(params.birthDate!)) {
        errors.add(ValidationError(
          ValidationErrorType.underAge,
          FieldType.birthDate,
        ));
      }
    }

    if (params.email.trim().isEmpty) {
      errors.add(ValidationError(
        ValidationErrorType.requiredEmail,
        FieldType.email,
      ));
    } else if (!params.email.contains('@')) {
      errors.add(ValidationError(
        ValidationErrorType.invalidEmail,
        FieldType.email,
      ));
    }

    if (params.phone.trim().isEmpty) {
      errors.add(ValidationError(
        ValidationErrorType.requiredPhone,
        FieldType.phone,
      ));
    }

    if (params.password.isEmpty) {
      errors.add(ValidationError(
        ValidationErrorType.requiredPassword,
        FieldType.password,
      ));
    } else if (params.password.length > 6) {
      errors.add(ValidationError(
        ValidationErrorType.passwordTooLong,
        FieldType.password,
      ));
    }

    if (params.confirmPassword.isEmpty) {
      errors.add(
        ValidationError(
          ValidationErrorType.requiredConfirmPassword,
          FieldType.confirmPassword,
        ),
      );
    } else if (params.password != params.confirmPassword) {
      errors.add(ValidationError(
        ValidationErrorType.passwordMismatch,
        FieldType.confirmPassword,
      ));
    }

    return errors;
  }

  static bool _isFutureDate(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return normalizedDate.isAfter(normalizedToday);
  }

  static bool _isAdult(DateTime date) {
    final today = DateTime.now();
    int age = today.year - date.year;

    if (today.month < date.month ||
        (today.month == date.month && today.day < date.day)) {
      age--;
    }

    return age >= 18;
  }

  static bool _isValidCPF(String cpf) {
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
}
