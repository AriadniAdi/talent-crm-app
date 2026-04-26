import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talent_crm_app/core/errors/app_error.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(DateTime.now());
  });
  late MockAuthRemoteDataSource dataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(dataSource);
  });

  group('AuthRepositoryImpl', () {
    const name = 'Test User';
    const email = 'test@example.com';
    const password = 'password123';
    const phone = '11988887777';
    const countryCode = '+55';
    const cpf = '12345678900';
    final birthDate = DateTime(1990, 1, 1);

    test('registerUser delegates to remote data source with all parameters',
        () async {
      when(
        () => dataSource.registerUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          phone: any(named: 'phone'),
          countryCode: any(named: 'countryCode'),
          cpf: any(named: 'cpf'),
          birthDate: any(named: 'birthDate'),
        ),
      ).thenAnswer((_) async => Success(true));

      final result = await repository.registerUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        countryCode: countryCode,
        cpf: cpf,
        birthDate: birthDate,
      );

      expect(result, isA<Success<bool>>());
      verify(
        () => dataSource.registerUser(
          name: name,
          email: email,
          password: password,
          phone: phone,
          countryCode: countryCode,
          cpf: cpf,
          birthDate: birthDate,
        ),
      ).called(1);
    });

    test('registerUser returns failure when data source fails', () async {
      final error = Failure<bool>(UnknownError());
      when(
        () => dataSource.registerUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          phone: any(named: 'phone'),
          countryCode: any(named: 'countryCode'),
          cpf: any(named: 'cpf'),
          birthDate: any(named: 'birthDate'),
        ),
      ).thenAnswer((_) async => error);

      final result = await repository.registerUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        countryCode: countryCode,
        cpf: cpf,
        birthDate: birthDate,
      );

      expect(result, equals(error));
    });
  });
}
