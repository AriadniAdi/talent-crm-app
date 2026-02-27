import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/l10n/app_localizations.dart';

import 'package:talent_crm_app/l10n/translate.dart';
import '../features/helpers/wrapper.dart';

void main() {
  testWidgets('LocalizationExtension returns AppLocalizations', (tester) async {
    await tester.pumpWidget(
      wrapper(
        Builder(
          builder: (context) {
            final l10n = context.translate;

            return Text(l10n.home);
          },
        ),
      ),
    );

    expect(find.textContaining('Início'), findsOneWidget);
  });

  testWidgets('context.translate equals AppLocalizations.of(context)',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        Builder(
          builder: (context) {
            final fromExtension = context.translate;
            final direct = AppLocalizations.of(context)!;

            expect(fromExtension, equals(direct));

            return const SizedBox();
          },
        ),
      ),
    );
  });
}
