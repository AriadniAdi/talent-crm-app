import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:talent_crm_app/features/account/entities/account.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/profile_avatar_button.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestWidget(Widget child) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: AppRoutes.account,
          page: () => const Scaffold(body: Text('Account Page')),
        ),
      ],
      home: Scaffold(body: child),
    );
  }

  testWidgets('renders CircleAvatar and letter', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const ProfileAvatarButton(
          account: Account(id: 1),
        ),
      ),
    );

    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('navigates to account route with correct parameter',
      (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const ProfileAvatarButton(
          account: Account(id: 42),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(Get.currentRoute.startsWith(AppRoutes.account), isTrue);
    expect(Get.parameters['id'], '42');
  });

  testWidgets('InkWell is tappable', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const ProfileAvatarButton(
          account: Account(id: 1),
        ),
      ),
    );

    final inkwell = tester.widget<InkWell>(
      find.byType(InkWell),
    );

    expect(inkwell.onTap, isNotNull);
  });
}
