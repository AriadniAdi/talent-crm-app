import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';

import '../../helpers/wrapper.dart';

void main() {
  testWidgets('AccountPage renders with BasePage and key', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );

    expect(find.byKey(const Key('account-page')), findsOneWidget);
  });
}
