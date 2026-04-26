import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AppLocaleService localeService;
  late MockAuthRepository authRepository;

  setUpAll(() {
    registerFallbackValue(
      const UserModel(
        uid: 'fallback',
        name: '',
        email: '',
      ),
    );
  });

  setUp(() {
    localeService = AppLocaleService.inMemory();
    authRepository = MockAuthRepository();
  });

  group('AccountController', () {
    test('id is assigned correctly', () {
      final controller = AccountController(
        '123',
        localeService: localeService,
        authRepository: authRepository,
      );

      expect(controller.id, '123');
    });

    test('changeLocale updates current locale', () async {
      final controller = AccountController(
        '123',
        localeService: localeService,
        authRepository: authRepository,
      );

      await controller.changeLocale(const Locale('es'));

      expect(controller.currentLocale.value, const Locale('es'));
    });

    test('loadProfile populates currentUser', () async {
      when(() => authRepository.getUserProfile(uid: '123')).thenAnswer(
        (_) async => Success(
          const UserModel(
            uid: '123',
            name: 'Ana',
            email: 'ana@example.com',
            phone: '11999990000',
            bio: 'Bio',
          ),
        ),
      );

      final controller = AccountController(
        '123',
        localeService: localeService,
        authRepository: authRepository,
      );

      await controller.loadProfile();

      expect(controller.currentUser.value?.name, 'Ana');
      expect(controller.screenError.value, isNull);
    });

    test('saveProfile updates current user when repository succeeds', () async {
      const currentUser = UserModel(
        uid: '123',
        name: 'Ana',
        email: 'ana@example.com',
        phone: null,
        bio: null,
      );

      when(() => authRepository.getUserProfile(uid: '123')).thenAnswer(
        (_) async => Success(currentUser),
      );
      when(
        () => authRepository.updateUserProfile(user: any(named: 'user')),
      ).thenAnswer((_) async => Success(true));

      final controller = AccountController(
        '123',
        localeService: localeService,
        authRepository: authRepository,
      );

      await controller.loadProfile();
      final result = await controller.saveProfile(
        name: 'Ana Souza',
        phone: '(11) 98888-7777',
        bio: 'Product designer',
      );

      expect(result, isA<Success<bool>>());
      expect(controller.currentUser.value?.name, 'Ana Souza');
      expect(controller.currentUser.value?.bio, 'Product designer');
      verify(() => authRepository.updateUserProfile(
            user: any(named: 'user'),
          )).called(1);
    });
  });
}
