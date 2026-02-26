import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:talent_crm_app/features/home/presentation/widgets/employee/employee_card.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:talent_crm_app/features/talent/entities/talent.dart';

import '../../../../../presentation/helpers/wrapper.dart';

void main() {
  late Talent fakeTalent;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    FlutterError.onError = (FlutterErrorDetails details) {};
    fakeTalent = const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Senior Developer',
      city: 'Porto Alegre',
      company: 'Talent Corp',
      website: 'website',
      contact: ContactTalent(email: 'email', phone: 'phone'),
    );
  });

  testWidgets('EmployeeCard renders employee name', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrapper(
          EmployeeCard(employee: fakeTalent),
        ),
      );
    });

    await tester.pumpAndSettle();

    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets('EmployeeCard renders avatar image', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrapper(
          EmployeeCard(employee: fakeTalent),
        ),
      );
    });

    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('EmployeeCard shows View Profile button', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrapper(
          EmployeeCard(employee: fakeTalent),
        ),
      );
    });

    expect(find.textContaining('Perfil'), findsOneWidget);
  });

  testWidgets('EmployeeCard button is tappable', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrapper(
          EmployeeCard(
            employee: fakeTalent,
            onViewProfile: () {},
          ),
        ),
      );
    });

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.byType(TextButton), findsOneWidget);
  });
}
