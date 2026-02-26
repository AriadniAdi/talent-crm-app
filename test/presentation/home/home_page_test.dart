import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:talent_crm_app/core/design/app_spacing.dart';
import 'package:talent_crm_app/core/global_binding.dart';
import 'package:talent_crm_app/features/home/home_binding.dart';
import 'package:talent_crm_app/features/talent/usecases/get_talents_usecase.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_content/home_content_view.dart';

import '../helpers/wrapper.dart';

class MockGetTalentsUseCase extends Mock implements GetTalentsUseCase {}

void main() {
  setUp(() {
    GlobalBinding().dependencies();
    HomeBinding().dependencies();
  });
  testWidgets('HomePage renders layout widgets', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const HomePage(),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    expect(find.byType(HomeSearchBar), findsOneWidget);
    expect(find.byType(HomeContentView), findsOneWidget);

    final sizedBoxes =
        tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();

    expect(sizedBoxes.any((s) => s.height == AppSpacing.lg), isTrue);
    expect(sizedBoxes.any((s) => s.height == AppSpacing.xl), isTrue);
  });
}
