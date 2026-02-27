import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';
import 'package:talent_crm_app/features/account/presentation/account_shell.dart';

import '../../helpers/wrapper.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.put(AccountController('123'));
  });

  testWidgets('AccountShell renders AccountPage', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const AccountShell(),
      ),
    );

    expect(find.byType(AccountPage), findsOneWidget);
  });
}
