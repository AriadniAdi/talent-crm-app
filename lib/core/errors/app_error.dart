sealed class AppError {}

class NetworkError extends AppError {}

class ServerError extends AppError {}

class NotFoundError extends AppError {}

class ParsingError extends AppError {}

class UnknownError extends AppError {}

class InvalidRouteError extends AppError {}

class AuthError extends AppError {
  final String? message;
  AuthError([this.message]);
}
