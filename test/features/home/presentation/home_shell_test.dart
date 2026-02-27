import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:talent_crm_app/features/home/presentation/home_shell.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';

import '../../../presentation/helpers/wrapper.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  late MockGetTalentsUseCase mockUseCase;
  late HomeController controller;

  setUp(() {
    Get.reset();

    mockUseCase = MockGetTalentsUseCase();
    when(() => mockUseCase()).thenAnswer(
      (_) async => Success(<Talent>[]),
    );

    controller = HomeController(mockUseCase);

    Get.put<HomeController>(controller);
  });

  tearDown(() {
    Get.reset();
  });
  testWidgets('HomeShell renders HomePage initially', (tester) async {
    await tester.pumpWidget(wrapper(const HomeShell()));

    await tester.pump();

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('HomeShell switches to Teams when index = 1', (tester) async {
    await tester.pumpWidget(wrapper(const HomeShell()));

    controller.selectedIndex.value = 1;
    await tester.pump();

    expect(find.textContaining('Equip'), findsOneWidget);
  });

  testWidgets('HomeShell switches to Notifications when index = 2',
      (tester) async {
    await tester.pumpWidget(wrapper(const HomeShell()));

    controller.selectedIndex.value = 2;
    await tester.pump();

    expect(find.textContaining('Notifica'), findsOneWidget);
  });

  testWidgets('HomeShell switches to Voice Notes when index = 3',
      (tester) async {
    await tester.pumpWidget(wrapper(const HomeShell()));

    controller.selectedIndex.value = 3;
    await tester.pump();

    expect(find.textContaining('Voz'), findsOneWidget);
  });
}
