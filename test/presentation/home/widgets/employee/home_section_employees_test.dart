import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/employee/employee_card.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  final employees = [
    const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Dev',
      city: 'POA',
      company: 'Tech',
      website: 'site.com',
      contact: ContactTalent(email: 'john@mail.com', phone: '9999'),
    ),
    const Talent(
      id: 2,
      name: 'Adi Machado',
      description: 'Flutter',
      city: 'POA',
      company: 'Mobile',
      website: 'adi.dev',
      contact: ContactTalent(email: 'adi@mail.com', phone: '8888'),
    ),
  ];

  group('HomeSectionEmployees', () {
    testWidgets('should render title and list when employees is not empty',
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          wrap(
            HomeSectionEmployees(
              title: 'Funcionários',
              employees: employees,
            ),
          ),
        );

        expect(find.text('Funcionários'), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Adi Machado'), findsOneWidget);
        expect(find.byType(CircleAvatar), findsNWidgets(2));
      });
    });
  });
}
