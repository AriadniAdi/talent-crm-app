import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/auth/presentation/login_page.dart';

import '../../helpers/wrapper.dart';

void main() {
  LoginPage buildPage({
    bool isLoading = false,
    VoidCallback? onContinueWithEmail,
    VoidCallback? onContinueWithGoogle,
  }) {
    return LoginPage(
      isLoading: isLoading,
      onContinueWithEmail: onContinueWithEmail ?? () {},
      onContinueWithGoogle: onContinueWithGoogle ?? () {},
    );
  }

  group('LoginPage Render', () {
    testWidgets('should render social login options and primary CTA', (
      tester,
    ) async {
      await tester.pumpWidget(wrapper(buildPage()));

      expect(find.text('Acesse sua conta'), findsOneWidget);
      expect(find.text('Continuar com Google'), findsOneWidget);
      expect(find.text('Continuar com Apple'), findsOneWidget);
      expect(find.text('Continuar com Facebook'), findsOneWidget);
      expect(find.text('Continuar com e-mail'), findsOneWidget);
      expect(find.text('Criar conta com e-mail'), findsOneWidget);
      expect(
        find.text('Apple será conectado na próxima etapa.'),
        findsOneWidget,
      );
      expect(
        find.text('Facebook será conectado na próxima etapa.'),
        findsOneWidget,
      );
    });

    testWidgets('should keep unsupported providers disabled', (tester) async {
      await tester.pumpWidget(wrapper(buildPage()));

      final appleButton = tester.widget<InkWell>(
        find.byKey(LoginPage.appleButtonKey),
      );
      final facebookButton = tester.widget<InkWell>(
        find.byKey(LoginPage.facebookButtonKey),
      );

      expect(appleButton.onTap, isNull);
      expect(facebookButton.onTap, isNull);
    });

    testWidgets('should trigger google callback when available',
        (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        wrapper(
          buildPage(
            onContinueWithGoogle: () {
              tapCount++;
            },
          ),
        ),
      );

      await tester.tap(find.byKey(LoginPage.googleButtonKey));
      await tester.pump();

      expect(tapCount, 1);
    });

    testWidgets('should disable google button while loading', (tester) async {
      await tester.pumpWidget(wrapper(buildPage(isLoading: true)));

      final googleButton = tester.widget<InkWell>(
        find.byKey(LoginPage.googleButtonKey),
      );

      expect(googleButton.onTap, isNull);
    });
  });
}
