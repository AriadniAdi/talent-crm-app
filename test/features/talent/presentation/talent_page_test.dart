import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/presentation/talent_page.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/talent_header_banner.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/info_card.dart';
import 'package:talent_crm_app/features/talent/presentation/widgets/observations_section.dart';
import '../../../presentation/helpers/wrapper.dart';

void main() {
  const talent = Talent(
    id: 1,
    name: 'Test User',
    website: 'site.com',
    company: 'company',
    description: '',
    city: '',
    contact: ContactTalent(email: 'test@test.com', phone: '123'),
  );

  testWidgets('renders all sections properly', (tester) async {
    await tester.pumpWidget(
      wrapper(
        TalentPage(talent: talent),
        surfaceSize: const Size(400, 800),
      ),
    );

    expect(find.byType(TalentHeaderBanner), findsOneWidget);
    expect(find.byType(InfoCard), findsOneWidget);
    expect(find.byType(ObservationsSection), findsOneWidget);
  });

  testWidgets('respects surfaceSize constraint', (tester) async {
    const size = Size(400, 600);

    await tester.pumpWidget(
      wrapper(
        TalentPage(talent: talent),
        surfaceSize: size,
      ),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);

    expect(sizedBox.width, size.width);
    expect(sizedBox.height, size.height);
  });

  testWidgets('can render centered content when requested', (tester) async {
    await tester.pumpWidget(
      wrapper(
        const Text('Centered'),
        center: true,
        surfaceSize: const Size(300, 200),
      ),
    );

    expect(find.byType(Center), findsOneWidget);
    expect(find.text('Centered'), findsOneWidget);
  });
}
