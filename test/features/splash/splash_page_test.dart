import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/splash/splash_page.dart';
import 'package:talent_crm_app/core/design/brand/talent_logo.dart';
import 'package:talent_crm_app/l10n/translate.dart';

import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/auth_manager.dart';

import '../helpers/wrapper.dart';

class FakeAppLinks extends Fake implements AppLinks {
  @override
  Future<Uri?> getInitialAppLink() async => null;
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class FakeAuthManager extends AuthManager {
  FakeAuthManager(FirebaseAuth auth) : super(auth: auth);
  bool _authenticated = false;

  void setAuthenticated(bool value) {
    _authenticated = value;
  }

  @override
  bool get isAuthenticated => _authenticated;

}

void main() {
  late FakeAuthManager fakeAuthManager;

  setUp(() {
    Get.testMode = true;
    Get.reset();
    
    final mockAuth = MockFirebaseAuth();
    when(() => mockAuth.authStateChanges()).thenAnswer((_) => const Stream.empty());
    when(() => mockAuth.currentUser).thenReturn(null);

    // Fake AppLinks for DeepLinkService if it gets initialized
    Get.lazyPut<AppLinks>(() => FakeAppLinks());
    
    fakeAuthManager = FakeAuthManager(mockAuth);
    Get.put<AuthManager>(fakeAuthManager);
  });

  tearDown(() {
    Get.reset();
  });
  testWidgets('SplashPage renders logo and title', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const SplashPage(
          delay: Duration.zero,
          enableNavigation: false,
        ),
      ),
    );

    expect(find.byType(TalentLogo), findsOneWidget);

    final context = tester.element(find.byType(SplashPage));
    final expectedTitle = context.translate.appTitle;

    expect(find.text(expectedTitle), findsOneWidget);
  });

  testWidgets('SplashPage navigates to login when not authenticated',
      (tester) async {
    fakeAuthManager.setAuthenticated(false);

    await tester.pumpWidget(
      wrapper(
        const SplashPage(
          delay: Duration.zero,
          enableNavigation: true,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('Login')), findsOneWidget);
  });

  testWidgets('SplashPage navigates to home when authenticated',
      (tester) async {
    fakeAuthManager.setAuthenticated(true);

    await tester.pumpWidget(
      wrapper(
        const SplashPage(
          delay: Duration.zero,
          enableNavigation: true,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('Home')), findsOneWidget);
  });
}
