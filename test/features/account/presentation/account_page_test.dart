import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/auth_manager.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';
import 'package:talent_crm_app/features/account/repositories/user_repository.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/core/result/result.dart';

import '../../helpers/wrapper.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockFirebaseUser extends Mock implements User {}
class TestAuthManager extends GetxController implements AuthManager {
  @override
  Rx<User?> user = Rx<User?>(null);

  @override
  bool get isAuthenticated => false;

  @override
  Future<void> signOut() async {}
}

void main() {
  late AccountController controller;

  setUp(() {
    Get.reset();
    Get.testMode = true;

    final localeService = AppLocaleService.inMemory();
    final userRepository = MockUserRepository();
    final authManager = TestAuthManager();

    // Mock a user in AuthManager so loadProfile doesn't fail early
    final mockFirebaseUser = MockFirebaseUser();
    when(() => mockFirebaseUser.uid).thenReturn('test-uid');
    when(() => mockFirebaseUser.email).thenReturn('test@example.com');
    authManager.user.value = mockFirebaseUser;

    // Mock userRepository.getUser
    const dummyUser = UserModel(
      uid: 'test-uid',
      name: 'Test User',
      email: 'test@example.com',
      phone: '(11) 99999-9999',
    );
    
    // Register success result
    when(() => userRepository.getUser(any()))
        .thenAnswer((_) async => Success(dummyUser));
    
    Get.put<AppLocaleService>(localeService);
    Get.put<UserRepository>(userRepository);
    Get.put<AuthManager>(authManager);

    controller = AccountController(
      localeService: localeService,
      userRepository: userRepository,
      authManager: authManager,
    );

    Get.put<AccountController>(controller, permanent: true);
  });

  tearDown(Get.reset);

  testWidgets('AccountPage renders with language selector', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );

    expect(find.byKey(const Key('account-page')), findsOneWidget);
    expect(find.byKey(const Key('language-selector-tile')), findsOneWidget);
    expect(find.text('Idioma'), findsOneWidget);
    expect(find.text('Português'), findsOneWidget);
  });

  testWidgets('AccountPage updates locale when a language is selected',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );

    await tester.tap(find.byKey(const Key('language-selector-tile')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-option-en')));
    await tester.pumpAndSettle();

    expect(controller.currentLocale.value, const Locale('en'));
    expect(find.text('English'), findsOneWidget);
  });
}
