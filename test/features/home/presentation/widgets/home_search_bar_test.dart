import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:talent_crm_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

import '../../../../presentation/helpers/wrapper.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  late HomeController controller;
  late MockGetTalentsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetTalentsUseCase();
    controller = HomeController(mockUseCase);

    Get.put<HomeController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('HomeSearchBar renders TextField and hint', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const HomeSearchBar(),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    expect(find.textContaining('Buscar'), findsOneWidget);
  });

  testWidgets('HomeSearchBar calls controller.search on input', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const HomeSearchBar(),
      ),
    );

    await tester.enterText(find.byType(TextField), 'John');
    await tester.pump();

    verify(() => mockUseCase()).called(1);
  });
}
