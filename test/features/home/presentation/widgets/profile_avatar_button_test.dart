import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/core/routes/app_routes.dart';

import 'package:talent_crm_app/features/account/entities/account.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/profile_avatar_button.dart';

import '../../../../presentation/helpers/wrapper.dart';

void main() {
  testWidgets('renders CircleAvatar and letter', (tester) async {
    await tester.pumpWidget(
      wrapper(
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
      wrapper(
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
      wrapper(
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
