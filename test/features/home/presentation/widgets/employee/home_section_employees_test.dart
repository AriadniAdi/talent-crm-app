import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/employee/home_section_employees.dart';

import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/employee/employee_card.dart';

import '../../../../../presentation/helpers/wrapper.dart';

void main() {
  late Talent fakeTalent1;
  late Talent fakeTalent2;

  setUp(() {
    fakeTalent1 = const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Senior Dev',
      city: 'Porto Alegre',
      company: 'Talent Corp',
      website: 'site',
      contact: ContactTalent(email: 'a', phone: 'b'),
    );

    fakeTalent2 = const Talent(
      id: 2,
      name: 'Jane Smith',
      description: 'Designer',
      city: 'SP',
      company: 'Design Co',
      website: 'site',
      contact: ContactTalent(email: 'a', phone: 'b'),
    );
  });

  testWidgets('returns SizedBox.shrink when employees is empty',
      (tester) async {
    await tester.pumpWidget(
      wrapper(
        const Scaffold(
          body: HomeSectionEmployees(
            title: 'Section',
            employees: [],
          ),
        ),
      ),
    );

    expect(find.byType(EmployeeCard), findsNothing);
    expect(find.text('Section'), findsNothing);
  });

  testWidgets('renders title and employee cards', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrapper(
          Scaffold(
            body: HomeSectionEmployees(
              title: 'Top Employees',
              employees: [fakeTalent1, fakeTalent2],
            ),
          ),
        ),
      );

      expect(find.text('Top Employees'), findsOneWidget);
      expect(find.byType(EmployeeCard), findsNWidgets(2));
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
    });
  });

  testWidgets('renders correct number of employees', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrapper(
          Scaffold(
            body: HomeSectionEmployees(
              title: 'Employees',
              employees: [fakeTalent1],
            ),
          ),
        ),
      );

      expect(find.byType(EmployeeCard), findsOneWidget);
    });
  });
}
