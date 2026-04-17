import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_params.dart';
import 'package:talent_crm_app/features/register/domain/usecases/register_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase useCase;

  const params = RegisterParams(
    name: 'Maria Silva',
    email: 'maria@email.com',
    password: '123456',
    confirmPassword: '123456',
    phone: '11999999999',
    countryCode: '+55',
    cpf: '52998224725',
    birthDate: null,
  );

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUseCase(repository);
  });

  group('RegisterUseCase', () {
    test('delegates registration to auth repository', () async {
      when(
        () => repository.registerUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Success(true));

      await useCase(params);

      verify(
        () => repository.registerUser(
          name: params.name,
          email: params.email,
          password: params.password,
        ),
      ).called(1);
    });

    test('throws app error when repository returns failure', () async {
      when(
        () => repository.registerUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Failure(AuthError('falha')));

      expect(
        () => useCase(params),
        throwsA(isA<AuthError>()),
      );
    });
  });
}
