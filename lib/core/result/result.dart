import 'package:talent_crm_app/core/errors/app_error.dart';

sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppError error;
  Failure(this.error);
}

extension ResultX<T> on Result<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(AppError error) failure,
  }) {
    return switch (this) {
      Success<T>(data: final d) => success(d),
      Failure<T>(error: final e) => failure(e),
    };
  }
}
