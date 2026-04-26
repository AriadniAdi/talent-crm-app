import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

import '../../helpers/wrapper.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AccountController controller;
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
    Get.reset();
    Get.testMode = true;

    final localeService = AppLocaleService.inMemory();
    authRepository = MockAuthRepository();

    when(() => authRepository.getUserProfile(uid: any(named: 'uid')))
        .thenAnswer(
      (_) async => Success(
        const UserModel(
          uid: '1',
          name: 'Ana Souza',
          email: 'ana@example.com',
          phone: '11988887777',
          bio: 'Flutter developer',
        ),
      ),
    );

    when(() => authRepository.updateUserProfile(user: any(named: 'user')))
        .thenAnswer((_) async => Success(true));

    Get.put<AppLocaleService>(localeService);

    controller = AccountController(
      '1',
      localeService: localeService,
      authRepository: authRepository,
    );

    Get.put<AccountController>(controller);
  });

  tearDown(Get.reset);

  testWidgets('AccountPage renders the current profile data', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('account-page')), findsOneWidget);
    expect(find.text('Ana Souza'), findsOneWidget);
    expect(find.text('ana@example.com'), findsOneWidget);
    expect(find.text('Flutter developer'), findsOneWidget);
    expect(find.byKey(const Key('language-selector-tile')), findsOneWidget);
  });

  testWidgets('AccountPage opens profile editor and saves changes',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Editar perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Editar perfil'), findsWidgets);
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Telefone'), findsWidgets);
    expect(find.text('Bio'), findsWidgets);

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), 'Ana Maria Souza');
    await tester.enterText(textFields.at(1), '(11) 97777-6666');
    await tester.enterText(textFields.at(2), 'Team lead');

    await tester.tap(find.text('Salvar alterações'));
    await tester.pumpAndSettle();

    expect(controller.currentUser.value?.name, 'Ana Maria Souza');
    expect(controller.currentUser.value?.bio, 'Team lead');
    verify(() => authRepository.updateUserProfile(
          user: any(named: 'user'),
        )).called(1);
  });

  testWidgets('AccountPage updates locale when a language is selected',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-selector-tile')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-option-en')));
    await tester.pumpAndSettle();

    expect(controller.currentLocale.value, const Locale('en'));
    expect(find.text('English'), findsOneWidget);
  });
}
