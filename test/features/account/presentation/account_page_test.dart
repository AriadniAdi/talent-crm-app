import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/widgets/base_page.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';

import '../../../presentation/helpers/wrapper.dart';

void main() {
  testWidgets('AccountPage renders with BasePage and title', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountPage(),
      ),
    );

    expect(find.byType(BasePage), findsOneWidget);

    expect(find.text('Account Page'), findsOneWidget);
  });
}
