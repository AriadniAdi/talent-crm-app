import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/auth/presentation/login_page.dart';

import '../../helpers/wrapper.dart';

void main() {
  LoginPage buildPage({
    bool isLoading = false,
    VoidCallback? onContinueWithEmail,
    VoidCallback? onContinueWithGoogle,
    VoidCallback? onContinueWithApple,
    VoidCallback? onContinueWithFacebook,
  }) {
    return LoginPage(
      isLoading: isLoading,
      onContinueWithEmail: onContinueWithEmail ?? () {},
      onContinueWithGoogle: onContinueWithGoogle ?? () {},
      onContinueWithApple: onContinueWithApple ?? () {},
      onContinueWithFacebook: onContinueWithFacebook ?? () {},
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
          find.text('Ideal para um acesso rápido e privado.'), findsOneWidget);
      expect(
        find.text('Entre com seu perfil social tradicional.'),
        findsOneWidget,
      );
    });

    testWidgets('should keep social buttons enabled when not loading',
        (tester) async {
      await tester.pumpWidget(wrapper(buildPage()));

      final appleButton = tester.widget<InkWell>(
        find.byKey(LoginPage.appleButtonKey),
      );
      final facebookButton = tester.widget<InkWell>(
        find.byKey(LoginPage.facebookButtonKey),
      );
      final googleButton = tester.widget<InkWell>(
        find.byKey(LoginPage.googleButtonKey),
      );

      expect(googleButton.onTap, isNotNull);
      expect(appleButton.onTap, isNotNull);
      expect(facebookButton.onTap, isNotNull);
    });
  });
}
