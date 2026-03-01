import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart' show GetResetExt;
import 'package:get/get_core/src/get_main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_crm_app/core/bootstrap/app_bootstrapper.dart';
import 'package:talent_crm_app/core/deep_link/deep_link_service.dart';
import 'package:talent_crm_app/main.dart';

class MockDeepLinkService extends Mock implements DeepLinkService {}

void main() {
  late MockDeepLinkService mockDeepLinkService;

  setUp(() {
    Get.reset();
    mockDeepLinkService = MockDeepLinkService();

    // Stub do método init (como ele retorna void, usamos verify depois ou answers)
    when(() => mockDeepLinkService.init()).thenReturn(null);
  });
  group('AppBootstrapper Tests', () {
    testWidgets('deve inicializar o DeepLinkService após o primeiro frame',
        (tester) async {
      // 1. Renderiza o widget passando o Mock
      await tester.pumpWidget(
        AppBootstrapper(deepLinkService: mockDeepLinkService),
      );

      // 2. O addPostFrameCallback precisa de um frame extra para disparar
      await tester.pump();

      verify(() => mockDeepLinkService.init()).called(1);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 3. Verifica se o método init foi chamado exatamente uma vez
      expect(find.byKey(const Key('my-app-key')), findsOneWidget);
    });

    testWidgets('deve renderizar o widget MyApp corretamente', (tester) async {
      await tester.pumpWidget(
        AppBootstrapper(deepLinkService: mockDeepLinkService),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verifica se o MyApp (que é o filho) está na árvore
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
