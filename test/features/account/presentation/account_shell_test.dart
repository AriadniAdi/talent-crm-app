import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/auth_manager.dart';
import 'package:talent_crm_app/core/locale/app_locale_service.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';
import 'package:talent_crm_app/features/account/presentation/account_shell.dart';
import 'package:talent_crm_app/features/account/repositories/user_repository.dart';

import '../../helpers/wrapper.dart';

class MockUserRepository extends Mock implements UserRepository {}
class TestAuthManager extends GetxController implements AuthManager {
  @override
  Rx<User?> user = Rx<User?>(null);

  @override
  bool get isAuthenticated => false;

  @override
  Future<void> signOut() async {}
}

void main() {
  setUp(() {
    Get.reset();
    final localeService = AppLocaleService.inMemory();
    final userRepository = MockUserRepository();
    final authManager = TestAuthManager();

    Get.put<AppLocaleService>(localeService);
    Get.put<UserRepository>(userRepository);
    Get.put<AuthManager>(authManager);
    
    Get.put(AccountController(
      localeService: localeService,
      userRepository: userRepository,
      authManager: authManager,
    ));
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
