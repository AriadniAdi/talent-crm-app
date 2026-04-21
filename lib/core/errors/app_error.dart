sealed class AppError {}

class NetworkError extends AppError {}

class ServerError extends AppError {}

class NotFoundError extends AppError {}

class ParsingError extends AppError {}

class UnknownError extends AppError {}

class InvalidRouteError extends AppError {}

class MessageError extends AppError {
  final String msg;
  MessageError(this.msg);
}

class AuthError extends AppError {
  final String? message;
  final AuthErrorCode? code;

  AuthError([this.message, this.code]);

  AuthError.withCode(this.code) : message = null;
}

enum AuthErrorCode {
  emailAlreadyInUse,
  invalidEmail,
  googleSignInCancelled,
  invalidCredentials,
  authenticationFailed,
}

enum ValidationErrorType {
  requiredName,
  invalidNameLength,
  invalidName,
  requiredCpf,
  invalidCpf,
  invalidBirthDate,
  futureBirthDate,
  underAge,
  requiredEmail,
  invalidEmail,
  requiredPhone,
  requiredPassword,
  passwordTooLong,
  requiredConfirmPassword,
  passwordMismatch,
  tooOld,
}

class ValidationError extends AppError {
  final ValidationErrorType type;
  final FieldType field;

  ValidationError(this.type, this.field);
}

enum FieldType {
  name,
  email,
  password,
  confirmPassword,
  phone,
  cpf,
  birthDate,
}
