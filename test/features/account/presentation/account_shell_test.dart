import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/core/result/result.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';
import 'package:talent_crm_app/features/account/presentation/account_shell.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

import '../../helpers/wrapper.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
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
    authRepository = MockAuthRepository();
    final localeService = AppLocaleService.inMemory();

    Get.put<AppLocaleService>(localeService);
    Get.put<AuthRepository>(authRepository);

    when(() => authRepository.getUserProfile(uid: any(named: 'uid')))
        .thenAnswer(
      (_) async => Success(
        const UserModel(
          uid: '123',
          name: 'Test User',
          email: 'test@example.com',
        ),
      ),
    );

    Get.put(
      AccountController(
        '123',
        localeService: localeService,
        authRepository: authRepository,
      ),
    );
  });

  testWidgets('AccountShell renders AccountPage', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountShell(),
      ),
    );

    expect(find.byType(AccountPage), findsOneWidget);
  });
}
