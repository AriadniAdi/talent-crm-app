import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';

import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/home_content/home_content.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  final recent = [
    const Talent(
      id: 1,
      name: 'Recent One',
      description: 'Dev',
      city: 'POA',
      company: 'Tech',
      website: 'site.com',
      contact: ContactTalent(email: 'r1@mail.com', phone: '1111'),
    ),
  ];

  final all = [
    const Talent(
      id: 2,
      name: 'All One',
      description: 'Flutter',
      city: 'POA',
      company: 'Mobile',
      website: 'adi.dev',
      contact: ContactTalent(email: 'a1@mail.com', phone: '2222'),
    ),
    const Talent(
      id: 3,
      name: 'All Two',
      description: 'QA',
      city: 'SP',
      company: 'Test',
      website: 'qa.com',
      contact: ContactTalent(email: 'a2@mail.com', phone: '3333'),
    ),
  ];

  testWidgets('renders both sections with correct titles', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrap(
          HomeContent(
            recent: recent,
            all: all,
          ),
        ),
      );
    });

    expect(find.text('Funcionários Recentes'), findsOneWidget);
    expect(find.text('Todos os Funcionários'), findsOneWidget);

    expect(find.text('Recent One'), findsOneWidget);
    expect(find.text('All One'), findsOneWidget);
    expect(find.text('All Two'), findsOneWidget);
  });
}
