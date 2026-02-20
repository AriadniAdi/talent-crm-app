import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/features/home/presentation/controller/home_controller.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_content/home_content_view.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  Widget wrap(Widget child) => GetMaterialApp(home: Scaffold(body: child));

  testWidgets('HomePage renders layout widgets', (tester) async {
    final mockUseCase = MockGetTalentsUseCase();
    when(() => mockUseCase()).thenAnswer((_) async => <Talent>[]);

    final controller = HomeController(
      mockUseCase,
      getRecentTalentsUseCase: const GetRecentTalentsUseCase(),
      searchTalentsUseCase: const SearchTalentsUseCase(),
    );

    Get.put<HomeController>(controller);

    await tester.pumpWidget(wrap(const HomePage()));
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);

    expect(find.byType(HomeSearchBar), findsOneWidget);
    expect(find.byType(HomeContentView), findsOneWidget);

    final sizedBoxes =
        tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();

    expect(sizedBoxes.any((s) => s.height == AppSpacing.lg), isTrue);
    expect(sizedBoxes.any((s) => s.height == AppSpacing.xl), isTrue);
  });
}
